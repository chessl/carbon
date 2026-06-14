+++
title = "Markdown Syntax"
date = 2020-01-05
toc = true
[taxonomies]
  tags = ["markdown"]
+++

For a quick cheatsheet, check out [https://simplemde.com/markdown-guide](https://simplemde.com/markdown-guide).

---

This article offers a sample of basic Markdown syntax that can be used in Blades content files, also it shows whether basic HTML elements are decorated with CSS in a Blades theme.

<!--more-->

# An h1 header

Paragraphs are separated by a blank line.

2nd paragraph. _Italic_, **bold**, ~~Strikethrough~~, and `monospace`. Itemized lists
look like:

- this one
- that one
- the other one

Note that --- not considering the asterisk --- the actual text
content starts at 4-columns in.

> Block quotes are
> written like so.
>
> They can span multiple paragraphs,
> if you like.
> **Note** that you can use _Markdown syntax_ within a blockquote.

Quote break.

> Blockquote with attribution
> Don't communicate by sharing memory, share memory by communicating.<br>
> — <cite>Rob Pike[^3]</cite>

Quote break.

> Blockquotes can also be nested...
>
> > ...by using additional greater-than signs right next to each other...
> >
> > > ...or with spaces between arrows.

[^3]: The above quote is excerpted from Rob Pike's [talk](https://www.youtube.com/watch?v=PAAkCSZUG1c) during Gopherfest, November 18, 2015.

Use 3 dashes for an em-dash. Use 2 dashes for ranges (ex., "it's all
in chapters 12--14"). Three dots ... will be converted to an ellipsis.
Unicode is supported. ☺

## An h2 header

Here's a numbered list:

1.  first item
2.  second item
3.  third item

Note again how the actual text starts at 4 columns in (4 characters
from the left side). Here's a code sample:

    # Let me re-iterate ...
    for i in 1 .. 10 { do-something(i) }

As you probably guessed, indented 4 spaces. By the way, instead of
indenting the block, you can use delimited blocks, if you like:

```sh
#!/bin/bash
for f in $(find . -maxdepth 2 -name '*.tif' -o -name '*.ppm'); do
    nf=${f%.*}.jpg
    wf=${f%.*}.webp

    convert $f -resize 2048x pnm:- | cjpeg -quality 80 -optimize > ${f%/*}/half/${nf##*/}
    echo ${f%/*}/half/${nf##*/} created

    convert $f -resize 1280x pnm:- | cjpeg -quality 80 -optimize > ${f%/*}/retina/${nf##*/}
    echo ${f%/*}/retina/${nf##*/} created

    convert $f -resize 768x pnm:- | cjpeg -quality 80 -optimize > ${f%/*}/thumb/${nf##*/}
    echo ${f%/*}/thumb/${nf##*/} created

    cwebp -resize 2048 0 -q 80 -m 6 -mt -hint photo -quiet $f -o ${f%/*}/half/${wf##*/}
    echo ${f%/*}/half/${wf##*/} created

    cwebp -resize 1280 0 -q 75 -m 6 -mt -hint photo -quiet $f -o ${f%/*}/retina/${wf##*/}
    echo ${f%/*}/retina/${wf##*/} created

    cwebp -resize 768 0 -q 85 -m 6 -mt -hint photo -quiet $f -o ${f%/*}/thumb/${wf##*/}
    echo ${f%/*}/thumb/${wf##*/} created

    ./rm $f
done
```

(which makes copying & pasting easier). You can optionally mark the
delimited block for Pandoc to syntax highlight it:

```rust,linenos,linenostart=20,name="main.rs",hl_lines=23-28
impl Display for HeadingLevel {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        match self {
            Self::H1 => write!(f, "h1"),
            Self::H2 => write!(f, "h2"),
            Self::H3 => write!(f, "h3"),
            Self::H4 => write!(f, "h4"),
            Self::H5 => write!(f, "h5"),
            Self::H6 => write!(f, "h6"),
        }
    }
}
```

### An h3 header

Now a nested list:

1.  First, get these ingredients:
    - carrots
    - celery
    - lentils

2.  Boil some water.

3.  Dump everything in the pot and follow
    this algorithm:

        find wooden spoon
        uncover pot
        stir
        cover pot
        balance wooden spoon precariously on pot handle
        wait 10 minutes
        goto first step (or shut off burner when done)

    Do not bump wooden spoon or it will fall.

Notice again how text always lines up on 4-space indents (including
that last line which continues item 3 above).

Here's a link to [a website](http://example.com), to a [local
doc](/about.html), and to a [section heading in the current
doc](/index.html). Here's a footnote [^1].

Another footnote [^2].

Tables can look like this:

Colons can be used to align columns.

| Tables        |      Are      |  Cool |
| ------------- | :-----------: | ----: |
| col 3 is      | right-aligned | $1600 |
| col 2 is      |   centered    |   $12 |
| zebra stripes |   are neat    |    $1 |

There must be at least 3 dashes separating each header cell.
The outer pipes (|) are optional, and you don't need to make the
raw Markdown line up prettily. You can also use inline Markdown.

| Markdown | Less      | Pretty     |
| -------- | --------- | ---------- |
| _Still_  | `renders` | **nicely** |
| 1        | 2         | 3          |

| First Header | Second Header |
| ------------ | ------------- |
| Content Cell | Content Cell  |
| Content Cell | Content Cell  |

| Command    | Description                                    |
| ---------- | ---------------------------------------------- |
| git status | List all new or modified files                 |
| git diff   | Show file differences that haven't been staged |

| Command      | Description                                        |
| ------------ | -------------------------------------------------- |
| `git status` | List all _new or modified_ files                   |
| `git diff`   | Show file differences that **haven't been** staged |

| Left-aligned | Center-aligned | Right-aligned |
| :----------- | :------------: | ------------: |
| git status   |   git status   |    git status |
| git diff     |    git diff    |      git diff |

| Name     | Character |
| -------- | --------- |
| Backtick | `         |
| Pipe     | \|        |

A horizontal rule follows.

---

and images can be specified like so:

![example image](https://picsum.photos/200/300 "An exemplary image")

Inline math equations go in like so: $omega = (dif phi) / (dif t)$. Display
math should get its own line and be put in in double-dollarsigns:

$$I = integral rho R^2 dif V$$

$$
e^x = lim_(n -> infinity) (1 + x / n)^n
$$

$$
f(a) = 1 / (2 pi i) integral.cont_gamma f(z) / (z - a) dif z
$$

[Web Math Demo](https://mk12.github.io/web-math-demo/).

And note that you can backslash-escape any punctuation characters
which you wish to be displayed literally, ex.: \`foo\`, \*bar\*, etc.

## D2 Diagrams

```d2
bank:   {
  style.fill: white
  Corporate:   {
    style.fill: white
    app14506: Data Source\ntco:      100,000\nowner: Lakshmi  {
      style:  {
        fill: '#fce7c6'
      }
    }
  }
  Equities:   {
    app14491: Risk Global\ntco:      600,000\nowner: Wendy  {
      style:  {
        fill: '#f6c889'
      }
    }
    app14492: Credit guard\ntco:      100,000\nowner: Lakshmi  {
      style:  {
        fill: '#fce7c6'
      }
    }
    app14520: Seven heaven\ntco:      100,000\nowner: Tomos  {
      style:  {
        fill: '#fce7c6'
      }
    }
    app14522: Apac Ace\ntco:      400,000\nowner: Wendy  {
      style:  {
        fill: '#f9d8a7'
      }
    }
    app14527: Risk Global\ntco:      900,000\nowner: Tomos  {
      style:  {
        fill: '#f4b76c'
      }
    }
  }
  Securities:   {
    style.fill: white
    app14517: Zone out\ntco:      500,000\nowner: Wendy  {
      style:  {
        fill: '#f6c889'
      }
    }
  }
  Finance:   {
    style.fill: white
    app14488: Credit guard\ntco:      700,000\nowner: India  {
      style:  {
        fill: '#f6c889'
      }
    }
    app14502: Ark Crypto\ntco:    1,500,000\nowner: Wendy  {
      style:  {
        fill: '#ed800c'
      }
    }
    app14510: Data Solar\ntco:    1,200,000\nowner: Deepak  {
      style:  {
        fill: '#f1a64f'
      }
    }
  }
  Risk:   {
    style.fill: white
    app14490: Seven heaven\ntco:            0\nowner: Joesph  {
      style:  {
        fill: '#fce7c6'
      }
    }
    app14507: Crypto Bot\ntco:    1,100,000\nowner: Wendy  {
      style:  {
        fill: '#f1a64f'
      }
    }
  }
  Funds:   {
    style.fill: white
    app14497: Risk Global\ntco:      500,000\nowner: Joesph  {
      style:  {
        fill: '#f6c889'
      }
    }
  }
  Fixed Income:   {
    style.fill: white
    app14523: ARC3\ntco:      600,000\nowner: Wendy  {
      style:  {
        fill: '#f6c889'
      }
    }
    app14500: Acmaze\ntco:      100,000\nowner: Tomos  {
      style:  {
        fill: '#fce7c6'
      }
    }
  }
}
bank.Risk.app14490 -> bank.Equities.app14527: client master
bank.Equities.app14491 -> bank.Equities.app14527: greeks  {
  style:  {
    stroke-dash: 5
    animated: true
    stroke: red
  }
}
bank.Funds.app14497 -> bank.Equities.app14520: allocations  {
  style:  {
    stroke-dash: 5
    animated: true
    stroke: brown
  }
}
bank.Equities.app14527 -> bank.Corporate.app14506: trades  {
  style:  {
    stroke-dash: 5
    animated: false
    stroke: blue
  }
}
bank.Fixed Income.app14523 -> bank.Equities.app14491: orders  {
  style:  {
    stroke-dash: 10
    animated: false
    stroke: green
  }
}
bank.Finance.app14488 -> bank.Equities.app14527: greeks  {
  style:  {
    stroke-dash: 5
    animated: true
    stroke: red
  }
}
bank.Equities.app14527 -> bank.Equities.app14522: orders  {
  style:  {
    stroke-dash: 10
    animated: false
    stroke: green
  }
}
bank.Equities.app14522 -> bank.Finance.app14510: orders  {
  style:  {
    stroke-dash: 10
    animated: false
    stroke: green
  }
}
bank.Equities.app14527 -> bank.Finance.app14502: greeks  {
  style:  {
    stroke-dash: 5
    animated: true
    stroke: red
  }
}
bank.Equities.app14527 -> bank.Risk.app14507: allocations  {
  style:  {
    stroke-dash: 5
    animated: true
    stroke: brown
  }
}
bank.Securities.app14517 -> bank.Equities.app14492: trades  {
  style:  {
    stroke-dash: 5
    animated: false
    stroke: blue
  }
}
bank.Equities.app14522 -> bank.Fixed Income.app14500: security reference
```

## Task lists

- [x] Finish my changes
- [ ] Push my commits to GitHub
- [ ] Open a pull request
- [x] @mentions, #refs, [links](https://example.com), **formatting**, and <del>tags</del> supported
- [x] list syntax required (any unordered or ordered list supported)
- [x] this is a complete item
- [ ] this is an incomplete item

## Other Elements — abbr, sub, sup, kbd, mark

<abbr title="Graphics Interchange Format">GIF</abbr> is a bitmap image format.

H<sub>2</sub>O

X<sup>n</sup> + Y<sup>n</sup> = Z<sup>n</sup>

Press <kbd><kbd>CTRL</kbd>+<kbd>ALT</kbd>+<kbd>Delete</kbd></kbd> to end the session.

Most <mark>salamanders</mark> are nocturnal, and hunt for insects, worms, and other small creatures.

[^1]: Footnote text goes here.

[^2]: Another footnote text goes here.
