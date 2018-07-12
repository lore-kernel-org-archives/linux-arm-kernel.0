From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 12 Jul 2018 09:34:09 +0200
Subject: [PATCH -next] drm/sun4i: DW HDMI: Make symbol
 sun8i_dw_hdmi_pltfm_driver static
In-Reply-To: <1531315367-190647-1-git-send-email-weiyongjun1@huawei.com>
References: <1531315367-190647-1-git-send-email-weiyongjun1@huawei.com>
Message-ID: <20180712073409.onkrxth7niearorq@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 11, 2018 at 01:22:47PM +0000, Wei Yongjun wrote:
> Fixes the following sparse warning:
> 
> drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c:228:24: warning:
>  symbol 'sun8i_dw_hdmi_pltfm_driver' was not declared. Should it be static?
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Applied, thanks!
Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180712/f53f2cb9/attachment.sig>
