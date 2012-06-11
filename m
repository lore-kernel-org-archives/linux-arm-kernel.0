From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 11 Jun 2012 15:28:22 +0000
Subject: [PATCH V2 0/6] Bridging PCI to amba
In-Reply-To: <CACRpkdbPtR5MDjd1YZ5GhOdp61HQe2PJusudNPOhDQHUAt1kJA@mail.gmail.com>
References: <cover.1338220457.git.rubini@gnudd.com>
 <CACRpkdbPtR5MDjd1YZ5GhOdp61HQe2PJusudNPOhDQHUAt1kJA@mail.gmail.com>
Message-ID: <201206111528.23034.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 10 June 2012, Linus Walleij wrote:
> On Mon, May 28, 2012 at 6:36 PM, Alessandro Rubini <rubini@gnudd.com> wrote:
> 
> > V2: accepted comments I got on V1; rewritten the driver to be generic;
> >    made it tristate instead of boolean. Rebased on new next.
> 
> This looks good to me.
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> I think this patch set could go through Arnd as arch maintainer?
> It's fun with these cross-arch things. You'll need an ACK from
> Russell first.

I don't think it has much to do with code I maintain. Russell
as the Primecell maintainer is the right person to take it through
his tree.

	Arnd
