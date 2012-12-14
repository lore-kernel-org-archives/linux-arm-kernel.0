From: iwamatsu@nigauri.org (Nobuhiro Iwamatsu)
Date: Sat, 15 Dec 2012 06:31:20 +0900
Subject: [PATCH 1/2] thermal: Add support for thermal sensor for Kirkwood
 SoC
In-Reply-To: <20121208001152.GA14363@n2100.arm.linux.org.uk>
References: <1354922151-3250-1-git-send-email-iwamatsu@nigauri.org>
 <20121208010708.260209f5@skate>
 <20121208001152.GA14363@n2100.arm.linux.org.uk>
Message-ID: <CABMQnVK4GkeNCJ59uZajBgd6N6JYcRsdQ9FxX-x+7+umm+8BCw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Dec 8, 2012 at 9:11 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Sat, Dec 08, 2012 at 01:07:08AM +0100, Thomas Petazzoni wrote:
>> Hello,
>>
>> On Sat,  8 Dec 2012 08:15:50 +0900, Nobuhiro Iwamatsu wrote:
>> > +static const struct of_device_id kirkwood_thermal_id_table[] = {
>> > +   { .compatible = "marvel,thermal-kirkwood" },
>>
>> marvel -> marvell
>>
>> Also, I think it should be marvell,kirkwood-thermal, since most other
>> DT compatible strings that we have for Marvell SoCs are
>> marvell,<soc>-<function>.
>>
>> Also, the Device Tree binding documentation is missing (even though it
>> is admittedly going to be a very short documentation).
>
> Is this in any way compatible with the thermal monitoring found on
> Dove (510) stuff?  If so, should it have the SoC prefix in there,
> or should it be "armada-thermal" for the SoC family?

I have document of armada and kirkwood only.
I dont know about Dove. if Dove has same device, we had better change
it is a good idea.

Best regards,
  Nobuhiro

-- 
Nobuhiro Iwamatsu
   iwamatsu at {nigauri.org / debian.org}
   GPG ID: 40AD1FA6
