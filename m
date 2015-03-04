From: jorge.ramirez-ortiz@linaro.org (Jorge Ramirez-Ortiz)
Date: Wed, 04 Mar 2015 15:52:59 -0500
Subject: [version 2]  amba uarts - arm type uarts fifo size provided by
 device tree
In-Reply-To: <20150303165534.GB10239@leverpostej>
References: <1424290069-8760-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <20150303165534.GB10239@leverpostej>
Message-ID: <54F770AB.8090004@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/03/2015 11:55 AM, Mark Rutland wrote:
> On Wed, Feb 18, 2015 at 08:07:47PM +0000, Jorge Ramirez-Ortiz wrote:
>> [PATCH 1/2] Documentation: bindings: add optional fifo size property
>> [PATCH 2/2] drivers/tty: pl011: read fifo size from OF if present [updated]
>>
>> These patches aim at resolving an issue present on some of the amba pl011 uarts.
>>
>> They were developed for the Hisilicon Hi6220 SoC where the fifo size on the
>> uarts is 64 despite the amba revision having been set to 1. 
> Are we certain that the FIFO length is the only difference between the
> HI6220 PL011 and a regular PL011?

I am trying to get an answer from the hardware designers.

>
> It may be worth adding a compatible string in addition, just in case.
>
> Mark.
