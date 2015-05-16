From: ijc@hellion.org.uk (Ian Campbell)
Date: Sat, 16 May 2015 11:08:46 +0100
Subject: [linux-sunxi] [RFC 0/7] ARM: sun9i: SMP support with
 Multi-Cluster Power Management
In-Reply-To: <1431583811-25780-1-git-send-email-wens@csie.org>
References: <1431583811-25780-1-git-send-email-wens@csie.org>
Message-ID: <1431770926.5748.41.camel@hellion.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2015-05-14 at 14:10 +0800, Chen-Yu Tsai wrote:
> This is my attempt to support SMP and CPU hot plugging on the Allwinner
> A80 SoC. The A80 is a big.Little processor with 2 clusters of 4x Cortex-A7
> and 4x Cortex-A15 cores.

I thought there was a preference these days to support this sort of
thing via support PSCI in the firmware, which allows for other things
such as non-secure-world etc.

Ian.
