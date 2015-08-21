From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 21 Aug 2015 09:43:37 +0200
Subject: [linux-sunxi][PATCH] ARM: sun7i: dt: Add new Olimex A20 EVB device
In-Reply-To: <55D6D674.7060205@redhat.com>
References: <1440002596-2611-1-git-send-email-codekipper@gmail.com>
 <20150820154545.GF30520@lukather>
 <CAEKpxBnQ+kCVYfE8JL5JzH5ZXb3azjwmjfAE5OXULaVm0bj2ew@mail.gmail.com>
 <55D6D674.7060205@redhat.com>
Message-ID: <55D6D6A9.3080006@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 21-08-15 09:42, Hans de Goede wrote:
> Hi,
>
> On 21-08-15 07:36, Code Kipper wrote:
>> On 20 August 2015 at 17:45, Maxime Ripard <maxime.ripard@free-electrons.com>
>> wrote:
>>
>>> Hi,
>>>
>>> On Wed, Aug 19, 2015 at 06:43:16PM +0200, codekipper at gmail.com wrote:
>>>> From: Marcus Cooper <codekipper@gmail.com>
>>>>
>>>> The A20-SOM-EVB is a reference design of a 2-layer board for the
>>>> A20-SOM.
>>>> It expands the features of A20-SOM by adding VGA connector, HDMI
>>>> connector, audio In/Out, LCD connector, 2 Mpix camera, gigabit
>>>> Ethernet, SATA, USB-OTG and 2 USB hosts.
>>>>
>>>> This patch adds basic support for the device
>>>> https://www.olimex.com/Products/SOM/A20/A20-SOM-EVB/
>>>>
>>>> More information on the SOM can be found here
>>>> http://linux-sunxi.org/Olimex_A20-SOM.
>>>>
>>>> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
>>>
>>> Is there any other SOM planned that could work with that baseboard? Or
>>> any other baseboard for that SOM?
>>>
>> I've seen neither. We could always create a som.dtsi later is one emerges.
>>
>>>
>>>> ---
>>>>   arch/arm/boot/dts/Makefile                    |   1 +
>>>>   arch/arm/boot/dts/sun7i-a20-olinuxino-evb.dts | 233
>>> ++++++++++++++++++++++++++
>>>>   2 files changed, 234 insertions(+)
>>>>   create mode 100644 arch/arm/boot/dts/sun7i-a20-olinuxino-evb.dts
>>>
>> Relooking at their website I can see that the device does not come under
>> the olinuxino brand so maybe I should rename the dts to
>> sun7i-a20-olimex-som-evb.dts
>
> Ack for renaming / +1
>
> Regards,
>
> Hans

p.s.

Can you please also send a v2 of the u-boot patch taking the renaming into
account ?

Regards,

Hans
