From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 30 May 2012 16:11:19 +0100
Subject: [PATCH 08/22] regulator: Change ab8500 match names to reflect
 Device Tree
In-Reply-To: <4FC63632.4030504@linaro.org>
References: <1338353260-10097-1-git-send-email-lee.jones@linaro.org>
 <1338353260-10097-9-git-send-email-lee.jones@linaro.org>
 <CACRpkdbQv8Q07iRAmG3UQRm7UNDi_Y+s_vvACDKKxR9tg+1iqg@mail.gmail.com>
 <20120530100302.GD9947@opensource.wolfsonmicro.com>
 <CAF2Aj3gZMF9ev9B46rBM+aY-srwthef09ad2CWfuXXFHmqqAjA@mail.gmail.com>
 <20120530121547.GJ9947@opensource.wolfsonmicro.com>
 <4FC63632.4030504@linaro.org>
Message-ID: <20120530151119.GN9947@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 30, 2012 at 11:01:06PM +0800, Lee Jones wrote:
> On 30/05/12 20:15, Mark Brown wrote:

> I personally think:

> 	vin-supply = <&db8500_vape_reg>;
> 	vmmc-supply = <&ab8500_ldo_aux2_reg>;

Oh, oops.  This is going to be fun when someone puts down two of the
same PMIC on a system...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120530/4420c68d/attachment-0001.sig>
