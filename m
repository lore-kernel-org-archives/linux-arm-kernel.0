From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 4 Apr 2015 15:36:12 +0200
Subject: [PATCH v2 0/5] ARM: sunxi: SRAM mapping support
In-Reply-To: <1427381625-6942-1-git-send-email-hdegoede@redhat.com>
References: <1427381625-6942-1-git-send-email-hdegoede@redhat.com>
Message-ID: <20150404133612.GM14618@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 26, 2015 at 03:53:40PM +0100, Hans de Goede wrote:
> Hi All,
> 
> Here is v2 of my cleaned up version of Maxime's sunxi SRAM controller driver.
> 
> Changes since v1:
> - Make the SUNXI_SRAM Kconfig option hidden, enabled by default if ARCH_SUNXI
> - Fix some typos in the comments in the dts file, both in the example in the
>   devicetree-binding documentation, as well as in the actual dts files
> - Drop the bogus change to drivers/net/ethernet/stmicro/stmmac/Kconfig
> 
> Since this is a prereq for my musb work, if there are no objections then I
> would like to see this go upstream soon.
> 
> Since it only touches sunxi files (and one Makefile), it is probably best if
> this all goes upstream through Maxime.

Merged patches 1-4. Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150404/2d5734d4/attachment-0001.sig>
