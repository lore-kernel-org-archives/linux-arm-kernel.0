From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 19 Apr 2016 11:58:53 +0200
Subject: [PATCH v3 09/19] ARM: sun5i: Add TV encoder gate to the DTSI
In-Reply-To: <1458751122-23976-10-git-send-email-maxime.ripard@free-electrons.com>
References: <1458751122-23976-1-git-send-email-maxime.ripard@free-electrons.com>
 <1458751122-23976-10-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20160419095853.GC26050@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 23, 2016 at 05:38:32PM +0100, Maxime Ripard wrote:
> It turns out that the A13 / R8 also have a tve encoder block, and a gate
> for it.
> 
> Add it to the DT.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> Acked-by: Chen-Yu Tsai <wens@csie.org>

Applied,

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160419/9044b419/attachment.sig>
