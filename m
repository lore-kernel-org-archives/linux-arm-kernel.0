From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 07 Jul 2016 12:01:50 +0200
Subject: [PATCH 1/2] ARM: multi_v7_defconfig: Enable AHCI_IMX
In-Reply-To: <20160621044349.GA24293@localhost>
References: <1466427854-21265-1-git-send-email-tuomas@tuxera.com>
 <20160621044349.GA24293@localhost>
Message-ID: <15374018.rdS7J5FcXR@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, June 20, 2016 9:43:49 PM CEST Olof Johansson wrote:
> Hi Toumas,
> 
> We can apply this directly but I prefer to get an acked-by from the
> platform maintainer that it affects. I didn't even see them cc:d here
> so would you mind resubmit with them on the line? Alternatively send it
> to them and they can apply and feed up to us with other defconfig changes.
> 
> 
> -Olof
> 
> On Mon, Jun 20, 2016 at 04:04:13PM +0300, Tuomas Tynkkynen wrote:
> > The Wandboard Quad comes with a SATA port. Enable the IMX SATA driver by
> > default to make it easy to have the root filesystem on it.
> > 
> > Signed-off-by: Tuomas Tynkkynen <tuomas@tuxera.com>

I haven't see a follow-up on these patches, are they still needed?

	Arnd
