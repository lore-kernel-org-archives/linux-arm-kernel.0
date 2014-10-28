From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 28 Oct 2014 22:10:56 +0100
Subject: [RFC 0/3] ARM: sun9i: Add PRCM clocks and reset controls support
In-Reply-To: <1413874167-6479-1-git-send-email-wens@csie.org>
References: <1413874167-6479-1-git-send-email-wens@csie.org>
Message-ID: <20141028211056.GC9255@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chen-Yu,

On Tue, Oct 21, 2014 at 02:49:24PM +0800, Chen-Yu Tsai wrote:
> This series adds basic support for the PRCM module on sun9i, which
> has clock and reset controls for the CPU-S or RTC block.
> 
> The series is marked RFC, because we do not have actual documentation
> for it. I am assuming the clock tree and register format is the same
> as the A31 and A23. Obviously we will need to do some testing to verify,
> which we would need actual peripherals to do.
> 
> I'm posting this so Maxime can test his pinctrl drivers, and then we
> can work out how to verify the clocks.

This looks fine overall, but I'm a bit worried that there is too much
that we don't really know about in this.

Do we need it right now, or can it wait for some A80 documents to be
released? Maybe we can just postpone this until we have more
informations on this if it's not going to be used anytime soon anyway.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141028/aa87c6b8/attachment.sig>
