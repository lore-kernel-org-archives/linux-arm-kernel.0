From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 27 Sep 2013 19:36:18 +0300
Subject: [PATCH 2/2] ARM: sunxi: Simplify restart setup code
In-Reply-To: <1379772706-7028-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1379772706-7028-1-git-send-email-maxime.ripard@free-electrons.com>
 <1379772706-7028-2-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20130927163618.GV2954@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 21, 2013 at 09:11:46AM -0500, Maxime Ripard wrote:
> Now that we have different machine definitions for different SoCs, we
> can remove the DT lookup to get the restart hook we should be using, and
> hardcode it in the machine definition instead.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Applied to my sunxi/core-for-3.13 branch.

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130927/88b9b5b3/attachment.sig>
