From: broonie@kernel.org (Mark Brown)
Date: Thu, 31 Jul 2014 21:22:31 +0100
Subject: [PATCH] ASoC: sirf-audio-codec: Fix return value check in
 sirf_audio_codec_driver_probe()
In-Reply-To: <1406678652-31950-1-git-send-email-weiyj_lk@163.com>
References: <1406678652-31950-1-git-send-email-weiyj_lk@163.com>
Message-ID: <20140731202231.GY17528@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 30, 2014 at 08:04:12AM +0800, weiyj_lk at 163.com wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> In case of error, the function devm_ioremap_resource() returns ERR_PTR()
> and never returns NULL. The NULL test in the return value check should
> be replaced with IS_ERR().

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140731/87729e18/attachment.sig>
