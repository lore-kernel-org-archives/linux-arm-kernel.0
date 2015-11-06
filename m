From: broonie@kernel.org (Mark Brown)
Date: Fri, 6 Nov 2015 10:45:41 +0000
Subject: [PATCH v3 1/2] ASoC: codec: Inno codec driver for RK3036 SoC
In-Reply-To: <1446799162-15635-2-git-send-email-zhengsq@rock-chips.com>
References: <1446799162-15635-1-git-send-email-zhengsq@rock-chips.com>
 <1446799162-15635-2-git-send-email-zhengsq@rock-chips.com>
Message-ID: <20151106104541.GC18409@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 06, 2015 at 04:39:21PM +0800, Shunqian Zheng wrote:

> +	SOC_ENUM("Anti-pop", rk3036_codec_antipop_enum),

As discussed this shouldn't be an enum.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151106/1b99ff75/attachment.sig>
