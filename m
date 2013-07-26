From: markus.mayer@linaro.org (Markus Mayer)
Date: Fri, 26 Jul 2013 16:22:07 -0700
Subject: [PATCH v3 2/3] ARM: bcm281xx: Device Tree bindings for GPIO driver
In-Reply-To: <51F301C4.4070807@wwwdotorg.org>
References: <1374870345-8276-1-git-send-email-markus.mayer@linaro.org>
 <1374870345-8276-3-git-send-email-markus.mayer@linaro.org>
 <51F2F37B.8030306@wwwdotorg.org>
 <CAPdLdqmU0aw5h_KYcD-E=isC9U3mZF6fzr_GVdjUUAW4_PUD5Q@mail.gmail.com>
 <51F301C4.4070807@wwwdotorg.org>
Message-ID: <CAPdLdqnq21zPNdJ_4iYS96yQH1XeuTp-TbwHpvkwsECHEKOKaQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26 July 2013 16:09, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 07/26/2013 04:51 PM, Markus Mayer wrote:
>> On 26 July 2013 15:08, Stephen Warren <swarren@wwwdotorg.org> wrote:
>>> (CC'ing the DT bindings maintainers hence quoting the binding in full)
>>>
>>> On 07/26/2013 02:25 PM, Markus Mayer wrote:
>
>>>> diff --git a/Documentation/devicetree/bindings/gpio/gpio-bcm-kona.txt b/Documentation/devicetree/bindings/gpio/gpio-bcm-kona.txt
>
>>>> +Required properties:
>>>> +  - compatible: "brcm,kona-gpio"
>>>> +  - reg: Physical base address and length of the controller's registers.
>>>> +  - interrupts: The interrupt outputs from the controller.
>>>
>>> How many entries are required? I notice there's more than 1 in the
>>> example below.
>>
>> You only "need" the ones you want to use, i.e. at least one. The board
>> supports up to 6. I can mention as much in the description.
>
> Isn't this a property of the SoC's IP block, not of the board?

Yes. I wasn't very precise with my statement.

What I added to the description is "Specify at least 1 GPIO interrupt.
The maximum number is 6."

-- 
Markus Mayer
Broadcom Landing Team
