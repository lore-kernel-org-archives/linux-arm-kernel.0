From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 6 Feb 2017 16:32:55 +0100
Subject: [PATCH -next] ASoC: sun4i-spdif: drop unnessary
 snd_soc_unregister_component()
In-Reply-To: <20170206152224.7566-1-weiyj.lk@gmail.com>
References: <20170206152224.7566-1-weiyj.lk@gmail.com>
Message-ID: <20170206153255.emowvun4nlssiyvs@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 06, 2017 at 03:22:24PM +0000, Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> It's not necessary to unregister a component registered
> with devm_snd_soc_register_component(). Also removed
> pointness clk_disable_unprepare() from error path and
> snd_soc_unregister_platform() from the remove.
> 
> Fixes: f8260afa444b ("ASoC: sunxi: Add support for the SPDIF block")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170206/0a945d6b/attachment-0001.sig>
