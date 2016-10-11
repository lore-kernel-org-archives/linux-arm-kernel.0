From: scott.branden@broadcom.com (Scott Branden)
Date: Tue, 11 Oct 2016 15:33:28 -0700
Subject: [PATCH] arm64: defconfig: enable EEPROM_AT25 config option
In-Reply-To: <1503155.onL8VV3RJv@wuerfel>
References: <1475875432-13627-1-git-send-email-scott.branden@broadcom.com>
 <a61b2b9d-356f-f24b-914b-0fb0e2bcdcc6@gmail.com> <1503155.onL8VV3RJv@wuerfel>
Message-ID: <c282ed21-d286-a85c-8d37-d54d30d1d7db@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On 16-10-10 02:20 AM, Arnd Bergmann wrote:
> On Monday, October 10, 2016 2:08:05 AM CEST Florian Fainelli wrote:
>> On 10/07/2016 02:23 PM, Scott Branden wrote:
>>> Enable support for on board SPI EEPROM by turning on
>>> CONFIG_EEPROM_AT25.
>>>
>>> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
>>
>> Looks fine to me, unless this needs to be a module, Arnd, what do you think?
>
> Please either make it a module or explain in the patch description
> why it should be built-in.

We use a fixed rootfs image to test the kernel.  For simplicity we don't 
construct a rootfs or load any modules.  We just test the kernel image. 
So for us every defconfig we use needs to be set to y to use the 
upstreamed kernel.

>
> 	Arnd
>

Regards,
  Scott
