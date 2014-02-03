From: Sudeep.Holla@arm.com (Sudeep Holla)
Date: Mon, 03 Feb 2014 15:56:25 +0000
Subject: about last level cache on big little cpu
In-Reply-To: <52EFACDC.7090103@linaro.org>
References: <52EFACDC.7090103@linaro.org>
Message-ID: <52EFBC29.5050406@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/02/14 14:51, Alex Shi wrote:
> Does all the big.LITTLE cpu share the same llc? or it depends on
> different vendor's products?
> 

It depends on implementation. e.g. on Cortex-A7 L2 is optional.
So there can be big.LITTLE system with CA15(with L2) and CA7(without L2).
In general depends are the choice of the processors in bL and if L2
is mandatory or optional on those processors.

Regards,
Sudeep
