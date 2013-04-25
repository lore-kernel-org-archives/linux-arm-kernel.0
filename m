From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 25 Apr 2013 12:49:31 +0100
Subject: [PATCH 30/32] ARM: ux500: Supply MMC DMA configuration via
 Device Tree
In-Reply-To: <CACRpkdbYXxkC2y9zCNcMAAmmQ7+3V0Y=hq7zgtp5L=Ts9QzpQQ@mail.gmail.com>
References: <1366279934-30761-1-git-send-email-lee.jones@linaro.org>
 <1366279934-30761-31-git-send-email-lee.jones@linaro.org>
 <CACRpkdbYXxkC2y9zCNcMAAmmQ7+3V0Y=hq7zgtp5L=Ts9QzpQQ@mail.gmail.com>
Message-ID: <20130425114931.GJ4623@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 25 Apr 2013, Linus Walleij wrote:

> On Thu, Apr 18, 2013 at 12:12 PM, Lee Jones <lee.jones@linaro.org> wrote:
> 
> > When requesting a channel, a DMA client needs to pass some pieces of
> > information such as; request channel, device type, channel type and
> > direction etc. Normally we do this in the form of platform data, but
> > when DT is enabled we need to pass it using the driver's bindings
> > instead.
> >
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> This requires that the pending MMCI patch get merged *first* right?

No, it doesn't. There is no harm in applying this *before*.

It will just lay dormant until it is.

> So you need to make sure Russell will merge that (or ACK it
> and include it) before you send any pull requests to me.
> 
> Apart from that it looks allright:
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
