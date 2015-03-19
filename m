From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 19 Mar 2015 18:23:21 +0100
Subject: [patch 2/7] dt: dtb version: document chosen/dtb-info node binding
In-Reply-To: <550B013B.1060002@gmail.com>
References: <550A42AC.8060104@gmail.com> <550A4382.4030209@gmail.com>
 <20150319134910.GF18473@leverpostej> <550B013B.1060002@gmail.com>
Message-ID: <CAMuHMdV1O2dpEW2yA2OFJ71zBm1aHSoiREmn3ujP5kEGZCN1GA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 19, 2015 at 6:02 PM, Frank Rowand <frowand.list@gmail.com> wrote:
>> Why would you _ever_ need an absolute path!?
>
> The absolute path tells you which source repository contained the source.

Really? Usually it's just gonna be <something>/linux-2.6...

IMHO it leaks information (the <something>) you don't want to be in final
build, like login names and file server names.
We already have way to many uses of __FILE__ in the kernel source tree.
Unfortunately there's no replacement macro with just the relative path,
against the topdir of the source tree.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
