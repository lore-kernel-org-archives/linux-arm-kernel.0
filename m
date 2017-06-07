From: broonie@kernel.org (Mark Brown)
Date: Wed, 7 Jun 2017 20:25:24 +0100
Subject: [PATCH v5 6/8] regulator: hi6421: Describe consumed platform
 device
In-Reply-To: <20170607070606.8889-7-guodong.xu@linaro.org>
References: <20170607070606.8889-1-guodong.xu@linaro.org>
 <20170607070606.8889-7-guodong.xu@linaro.org>
Message-ID: <20170607192524.ggci4pn47smrduex@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 07, 2017 at 03:06:04PM +0800, Guodong Xu wrote:
> The hi6421-regulator driver consumes a similarly named platform device.
> Adding that to the module device table, allows modprobe to locate this
> driver once the device is created.

You need this in hi6421v530 too.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170607/fd3df26c/attachment.sig>
