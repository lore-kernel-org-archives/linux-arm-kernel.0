From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 14 Apr 2014 11:59:07 +0200
Subject: [PATCH 2/4] ARM: sun7i: fix PLL4 clock and add PLL8
In-Reply-To: <1395253173-30437-3-git-send-email-emilio@elopez.com.ar>
References: <1395253173-30437-1-git-send-email-emilio@elopez.com.ar>
 <1395253173-30437-3-git-send-email-emilio@elopez.com.ar>
Message-ID: <20140414095907.GA3207@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 19, 2014 at 03:19:31PM -0300, Emilio L?pez wrote:
> Allwinner reworked the PLL4 clock in sun7i; so we need to change the
> compatible. Additionally, PLL8 is compatible with this new PLL4
> implementation, so let's add a node for it as well.
> 
> Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>

Applied to sunxi/fixes-for-3.15.

Thanks!
Maxime

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140414/ab8d5ed0/attachment.sig>
