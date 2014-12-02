From: Roman.Byshko@uni-konstanz.de (Roman Byshko)
Date: Tue, 2 Dec 2014 14:01:50 +0100
Subject: [linux-sunxi] [PATCH v2 0/5] ARM: sunxi: Add support for USB OTG
 PHY
In-Reply-To: <5461D2C1.6020505@redhat.com>
References: <cover.1415645258.git.rbyshko@gmail.com>
 <5461D2C1.6020505@redhat.com>
Message-ID: <CAMXmWBkG50yq323T-EU8CredkoP2vaJwkvV6Df5t7bBS861q3Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 11, 2014 at 10:11 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi,
>
> On 11/10/2014 07:55 PM, Roman Byshko wrote:
>> Hi,
>>
>> There is already support for two USB phys, which are used for
>> USB host controllers on Allwinner SoC aka sunxi.
>>
>> This patch series add support for the USB OTG phy (aka phy0).
>>
>> The code has been tested on Allwinner A20 aka sun7i (Cubietruck).
>>
>> Best regards,
>> Roman Byshko
>
> First of all very cool that you're working on this, I somehow missed
> v1, but I'm very happy to see this.
>
> Second some questions, this series seems to only add support for
> initializing the phy, without adding the necessary magic for
> switching from app to host mode, and without actually hooking up musb,
> I assume you've a follow up series adding musb support, which actually
> uses the phy ?

Yes, there will be follow ups.

> Also have you coordinated your work with ChenYu? ATM ChenYu is mostly
> working on other stuff, but AFAIk he has been working on musb support
> in the past.

Yes.

Best,
Roman
>
> Regards,
>
> Hans
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
