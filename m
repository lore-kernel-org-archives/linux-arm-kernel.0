From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 26 Jan 2018 09:10:00 +0100
Subject: [PATCH v6 2/2] media: V3s: Add support for Allwinner CSI.
In-Reply-To: <20180126110041.f89848325b9ecfb07df387ca@magewell.com>
References: <1516695531-23349-1-git-send-email-yong.deng@magewell.com>
 <201801260759.RyNhDZz4%fengguang.wu@intel.com>
 <20180126094658.aa70ed3f890464f6051e21e4@magewell.com>
 <20180126110041.f89848325b9ecfb07df387ca@magewell.com>
Message-ID: <20180126081000.hy7g57zp5dv6ug2g@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 26, 2018 at 11:00:41AM +0800, Yong wrote:
> Hi Maxime,
> 
> On Fri, 26 Jan 2018 09:46:58 +0800
> Yong <yong.deng@magewell.com> wrote:
> 
> > Hi Maxime,
> > 
> > Do you have any experience in solving this problem?
> > It seems the PHYS_OFFSET maybe undeclared when the ARCH is not arm.
> 
> Got it.
> Should I add 'depends on ARM' in Kconfig?

Yes, or even better a depends on MACH_SUNXI :)

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180126/53e9dc57/attachment.sig>
