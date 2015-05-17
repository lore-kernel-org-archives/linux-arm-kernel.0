From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 17 May 2015 16:38:16 +0200
Subject: [linux-sunxi] [RFC 0/7] ARM: sun9i: SMP support with
 Multi-Cluster Power Management
In-Reply-To: <1431770926.5748.41.camel@hellion.org.uk>
References: <1431583811-25780-1-git-send-email-wens@csie.org>
 <1431770926.5748.41.camel@hellion.org.uk>
Message-ID: <20150517143816.GJ4004@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ian,

On Sat, May 16, 2015 at 11:08:46AM +0100, Ian Campbell wrote:
> On Thu, 2015-05-14 at 14:10 +0800, Chen-Yu Tsai wrote:
> > This is my attempt to support SMP and CPU hot plugging on the Allwinner
> > A80 SoC. The A80 is a big.Little processor with 2 clusters of 4x Cortex-A7
> > and 4x Cortex-A15 cores.
> 
> I thought there was a preference these days to support this sort of
> thing via support PSCI in the firmware, which allows for other things
> such as non-secure-world etc.

Yes, it is the preferred way. Meaning that if someone wants to do that
work, he's very much welcome and encouraged to do so. But if no one's
doing it, then we still have to have a way to bringup the secondary
CPUs.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150517/8157c4af/attachment.sig>
