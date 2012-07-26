From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 26 Jul 2012 16:14:05 +0100
Subject: [PATCH 20/21] ASoC: codecs: Enable AB8500 CODEC for Device Tree
In-Reply-To: <50115BBA.2020400@linaro.org>
References: <1343298534-13611-1-git-send-email-lee.jones@linaro.org>
 <1343298534-13611-21-git-send-email-lee.jones@linaro.org>
 <20120726115055.GD3099@opensource.wolfsonmicro.com>
 <50114D71.9060700@linaro.org>
 <20120726142825.GK3099@opensource.wolfsonmicro.com>
 <50115BBA.2020400@linaro.org>
Message-ID: <20120726151404.GP3099@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 26, 2012 at 04:01:14PM +0100, Lee Jones wrote:

> This is the only value which the user can pick an obscure value,
> such as 913, thinking they can pick 913mV. I'm happy to fall-back,
> as long as Ola is too.

Erroring out if they pick an invalid value is fine, I'm more concerned
with the case where no property is supplied at all.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120726/0c9093c9/attachment.sig>
