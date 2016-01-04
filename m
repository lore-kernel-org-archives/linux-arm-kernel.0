From: lho@apm.com (Loc Ho)
Date: Sun, 3 Jan 2016 22:23:44 -0800
Subject: [PATCH v2 0/2] i2c:dw: Add APM X-Gene ACPI I2C device support
In-Reply-To: <4133541.hlxbdmvYbG@vostro.rjw.lan>
References: <1449782357-22982-1-git-send-email-lho@apm.com>
 <4133541.hlxbdmvYbG@vostro.rjw.lan>
Message-ID: <CAPw-ZTkZ5Su9CfgGQCHGFFCw-RE=tFeCF1GyMP3EUaZ8WDisSg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Jan 2, 2016 at 4:54 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Thursday, December 10, 2015 02:19:15 PM Loc Ho wrote:
>> Add APM X-Gene ACPI I2C device support. These patches follow
>> the same implementation as AMD I2C driver - changes in ACPI APD
>> and Designware I2C drivers.
>>
>> v2:
>> * Spilt the acpi_apd change with defines for AMD and X-Gene I2C's
>>
>> Signed-off-by: Loc Ho <lho@apm.com>
>> ---
>> Loc Ho (2):
>>   acpi:apd: Add APM X-Gene ACPI I2C device support
>>   i2c:dw: Add APM X-Gene ACPI I2C device support
>
> Both patches applied, thanks!
>

Thanks...

-Loc
