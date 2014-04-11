From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 11 Apr 2014 15:05:52 +0200
Subject: [PATCH v3 1/7] pinctrl: sunxi: check clk_prepare_enable return
 value
In-Reply-To: <1397137966-30818-2-git-send-email-boris.brezillon@free-electrons.com>
References: <1397137966-30818-1-git-send-email-boris.brezillon@free-electrons.com>
 <1397137966-30818-2-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20140411130552.GX28585@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On Thu, Apr 10, 2014 at 03:52:40PM +0200, Boris BREZILLON wrote:
> Check the clk_prepare_enable return value to avoid false positive probe.
> 
> Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140411/fa5f0e57/attachment.sig>
