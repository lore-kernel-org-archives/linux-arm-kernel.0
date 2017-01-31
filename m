From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 31 Jan 2017 19:24:38 +0000
Subject: [PATCH v3 0/3] ARM: !MMU: v7-A support, dynamic vectors base
 handling
In-Reply-To: <20170131130446.5829-1-afzal.mohd.ma@gmail.com>
References: <20170131130446.5829-1-afzal.mohd.ma@gmail.com>
Message-ID: <20170131192438.GB27312@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 31, 2017 at 06:34:46PM +0530, afzal mohammed wrote:
> Hi,
> 
> ARM core changes to support !MMU Kernel on v7-A MMU processors.
> 
> Based on the feedback from Russell, it was decided to handle vector
> base dynamically in C for no-MMU & work towards the the goal of
> removing VECTORS_BASE from Kconfig.

Looks good from my perspective.  If Vladimir can reply about patch 2,
then I think we'll be good to go with these.  Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
