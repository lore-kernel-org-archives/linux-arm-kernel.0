From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 14 May 2014 14:34:19 +0200
Subject: [PATCH RESEND v4 0/8] Add Allwinner A31 USB support
In-Reply-To: <1399995862-17788-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1399995862-17788-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20140514123419.GK29258@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 13, 2014 at 05:44:14PM +0200, Maxime Ripard wrote:
> Hi everyone,
> 
> This patchset adds support for the USB controllers found in the
> Allwinner A31.
> 
> While the design is similar to the earlier Allwinner SoCs that are
> already supported, a few details here and there change, like the fact
> that the PHYs now have one clock per phy, while it used to be only one
> for all the PHYs.
> 
> Resent adding Alan Stern's Acked-by and puting Greg KH in the
> recipients this time...

Applied patches 2, 7 and 8.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140514/a5425997/attachment.sig>
