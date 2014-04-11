From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 11 Apr 2014 15:07:02 +0200
Subject: [PATCH v3 6/7] pinctrl: sunxi: add reset control support
In-Reply-To: <1397137966-30818-7-git-send-email-boris.brezillon@free-electrons.com>
References: <1397137966-30818-1-git-send-email-boris.brezillon@free-electrons.com>
 <1397137966-30818-7-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20140411130702.GZ28585@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Apr 10, 2014 at 03:52:45PM +0200, Boris BREZILLON wrote:
> The A31 SoC define a reset line for the R_PIO block which needs to be
> deasserted.
> 
> Try to retrieve a reset control and deassert if one was found.
> 
> Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140411/45176aec/attachment-0001.sig>
