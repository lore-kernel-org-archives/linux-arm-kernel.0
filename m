From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 24 Mar 2016 19:45:28 +0100
Subject: [PATCH 0/2] ARM: sunxi: dt: Add missing DRAM gate clock for
 simplefb TV output
In-Reply-To: <1458842920-30854-1-git-send-email-Priit.Laes@icefire.ee>
References: <1458842920-30854-1-git-send-email-Priit.Laes@icefire.ee>
Message-ID: <20160324184528.GZ30977@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Mar 24, 2016 at 08:08:38PM +0200, Priit Laes wrote:
> From: Priit Laes <plaes@plaes.org>
> 
> DRAM gating driver commit for sun[47]i seems to be missing DRAM gate bit 5 for
> simplefb TV output node. Add it.

Thanks, could you please add the Fixes tag and Cc stable ?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160324/3aad03d9/attachment.sig>
