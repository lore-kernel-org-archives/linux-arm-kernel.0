From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 25 Jan 2013 09:51:47 +0100
Subject: [PATCH v3 2/3] gpio: pca953x: add support for pca9505
In-Reply-To: <51024422.2060503@free-electrons.com>
References: <1358889025-8530-1-git-send-email-gregory.clement@free-electrons.com>
 <1358889025-8530-3-git-send-email-gregory.clement@free-electrons.com>
 <CACRpkda-N0GrKOeaz4Hji0ef9pSRNPCxW_jLGR28iX-sk0-=tg@mail.gmail.com>
 <51024422.2060503@free-electrons.com>
Message-ID: <CACRpkdbe1fGVLNyJ+U+ozE32p+_fc-eQ4W1F8OeYC+fryu_dQQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 25, 2013 at 9:36 AM, Gregory CLEMENT
<gregory.clement@free-electrons.com> wrote:

> Well, at the beginning I thought adding support for pca9505 was just a matter
> of a couple of lines to add. Then I realized that I need to handle the 40 bits
> case, and I ended up refactoring all access to the registers. So now I am on it,
> it seems I am volunteer to continue to improve this driver.

I like the sound of this ;-)

To get you started I just sent out two other patches you can consider
as RFC, they're regrettably not even compile-tested. I mainly wanted
to indicate what needs to be done so we can throw them away, just
wanted to give a hint.

> However I won't be able to test it, the only PXA based platform I have is a
> Zaurus SL-C3100 which embeds a PXA270 if I remember well, but I doubt it come
> with gpio expander on i2c.

Well I guess if there is nobody testing it, then nobody cares.
The world must be full of people with PXA platforms doing nothing
but regression testing...

Actually just days ago I asked Haoijan to help me testing a set of
patches for the PXA SPI controller, and he kindly helped out, so there
are some people booting these platforms, sometimes :-)

Yours,
Linus Walleij
