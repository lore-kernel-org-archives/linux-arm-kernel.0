From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 5 Jun 2012 11:38:46 +0100
Subject: [PATCH 08/22] regulator: Change ab8500 match names to reflect
 Device Tree
In-Reply-To: <4FCDDFFC.3000902@linaro.org>
References: <20120530100302.GD9947@opensource.wolfsonmicro.com>
 <CAF2Aj3gZMF9ev9B46rBM+aY-srwthef09ad2CWfuXXFHmqqAjA@mail.gmail.com>
 <20120530121547.GJ9947@opensource.wolfsonmicro.com>
 <4FC63632.4030504@linaro.org>
 <20120530151119.GN9947@opensource.wolfsonmicro.com>
 <4FC63B39.6040905@linaro.org>
 <20120530164152.GP9947@opensource.wolfsonmicro.com>
 <4FC846CC.20801@linaro.org>
 <20120601084850.GJ24139@opensource.wolfsonmicro.com>
 <4FCDDFFC.3000902@linaro.org>
Message-ID: <20120605103846.GQ23408@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 05, 2012 at 11:31:24AM +0100, Lee Jones wrote:
> On 01/06/12 09:48, Mark Brown wrote:

> >What makes you say the two are equivalent?  The former is a reference
> >from a consumer device to a named regulator while the latter is a
> >reference from a regulator to a named consumer.

> I mean they both link regulator<->consumer and apply the name "vmmc"
> to the supply, or am I missing something / getting confused?

You're missing something - note what I say above about the direction the
mapping is done in, and consider what happens if we've got two of the
same PMIC down in a system.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120605/2600ed6b/attachment.sig>
