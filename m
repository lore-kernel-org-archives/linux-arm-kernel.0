From: bcousson@baylibre.com (Benoit Cousson)
Date: Tue, 13 Aug 2013 16:48:47 +0200
Subject: [PATCH] arm: omap5: dts: split SMPS10 dt node
In-Reply-To: <520A4685.7050503@ti.com>
References: <1376300221-15172-1-git-send-email-kishon@ti.com>
 <520A32CF.1010701@baylibre.com> <520A4685.7050503@ti.com>
Message-ID: <520A474F.9080500@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/08/2013 16:45, Kishon Vijay Abraham I wrote:
> Hi,
>
> On Tuesday 13 August 2013 06:51 PM, Benoit Cousson wrote:
>> Hi Kishon,
>>
>> On 12/08/2013 11:37, Kishon Vijay Abraham I wrote:
>>> SMPS10 has two outputs OUT1 and OUT2. Hence SMPS10 is modeled as
>>> two regulators. The dt node is split to reflect it.
>>
>> Mmm, I'm curious. How is it supposed to work?
>>
>> Do you have dedicated control on each output?
>
> Yes. It can be controlled by setting different values to the same bit fields.
> You can refer [1] where we actually implement SMPS10 as two different regulators.
>
> [1] -> http://permalink.gmane.org/gmane.linux.kernel/1542521

Great, thanks.

Can we merge that one safely if the driver changed are not done yet?

Regards,
Benoit
