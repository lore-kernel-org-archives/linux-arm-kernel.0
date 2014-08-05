From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Tue, 05 Aug 2014 11:34:10 +0800
Subject: [Linaro-acpi] [PATCH v2 00/18] Introduce ACPI for ARM64 based
 on ACPI 5.1
In-Reply-To: <CAJRNFK+UfJhGR65tOecy=X+YdHQHiNPZ4p_p8LUxhRL3GW5gFw@mail.gmail.com>
References: <1407166105-17675-1-git-send-email-hanjun.guo@linaro.org>
 <CAJRNFK+UfJhGR65tOecy=X+YdHQHiNPZ4p_p8LUxhRL3GW5gFw@mail.gmail.com>
Message-ID: <53E050B2.2080609@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014-8-5 1:30, Alexander Spyridakis wrote:
> On 4 August 2014 17:28, Hanjun Guo <hanjun.guo@linaro.org
> <mailto:hanjun.guo@linaro.org>> wrote:
>>
>> ACPI 5.1 has been released and now be freely available for
>> download [1]. It fixed some major gaps to run ACPI on ARM,
>> this patch just follow the ACPI 5.1 spec and prepare the
>> code to run ACPI on ARM64.
> 
> Hello,

Hi,

> 
> Is this work still reproducible on Foundation and/or ARMv8 FVP models, as
> described in the following wiki page?
> https://wiki.linaro.org/LEG/Engineering/Kernel/ACPI

Yes, I think so. If you meet any problem , please let us know, and we will
update the wiki.

> 
> Should I assume that UEFI is mandatory (alternative being the aarch64
> bootwrapper), as described in Documentation/arm64/arm-acpi.txt?

Yes, UEFI is mandatory if you want to use ACPI.

> 
> Thanks in advance.

You are welcome :)

Thanks
Hanjun
