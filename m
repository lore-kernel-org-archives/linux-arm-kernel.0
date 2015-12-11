From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 11 Dec 2015 19:07:11 +0000
Subject: [PATCH 1/2] ARM: Documentation: l2c: Rename l2cc to l2x0
In-Reply-To: <1449860267-16154-1-git-send-email-dirk.behme@gmail.com>
References: <1449860267-16154-1-git-send-email-dirk.behme@gmail.com>
Message-ID: <20151211190711.GX8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 11, 2015 at 07:57:46PM +0100, Dirk Behme wrote:
> The documentation in the l2cc.txt is specific to the L2 cache
> controllers PL210/PL220/PL310 (and variants) and not generic
> as the file name implies. It's not valid for integrated L2
> controllers as found in e.g. Cortex-A15/A7/A57/A53.

Please change it to l2c2x0.txt - and please change the PL prefix above
to L2C.  ARMs documentation uses the L2C prefix rather than PL for these.

Thanks.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
