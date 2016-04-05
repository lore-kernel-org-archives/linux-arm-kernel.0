From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 5 Apr 2016 09:57:54 +0200
Subject: [PATCH RESEND] ARM: l2x0: add three special L210 aux control flags
In-Reply-To: <20160405074315.GX19428@n2100.arm.linux.org.uk>
References: <1458043882-16881-1-git-send-email-linus.walleij@linaro.org>
 <CACRpkdZeAKkU4Cr6TTQor_6zw2iVGgXmTdcsQuHuR07Q8yZHiQ@mail.gmail.com>
 <20160405074315.GX19428@n2100.arm.linux.org.uk>
Message-ID: <CACRpkdakozuVt8F9siqxULp7oYqoeXtmnobw3CWbmHkz6hs+nQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 5, 2016 at 9:43 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

> I haven't forgotten it, but I do wonder whether this endless shovelling
> of more and more DT properties is really the way forward, or whether
> some of this stuff should be handled by the boot loader/firmware.
>
> That's the reason that you get the:
>
> "L2C: DT/platform modifies aux control register: 0x%08x -> 0x%08x"
>
> message at _warning_ level.

I see your concern.

Unfortunately it's one of those bootloaders that I cannot replace.
There is nothing in the way of official support for it, and
you have to use a custom protocol to replace the boot loader,
so if I start to experiment with it I may end up bricking my
device beyond recovery :(

Yours,
Linus Walleij
