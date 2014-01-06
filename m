From: al.stone@linaro.org (Al Stone)
Date: Mon, 06 Jan 2014 15:38:39 -0700
Subject: [PATCH v4 1/5] ACPI: introduce CONFIG_ACPI_REDUCED_HARDWARE to
 enable this ACPI mode
In-Reply-To: <20131227045848.GB21429@srcf.ucam.org>
References: <1387239401-13918-1-git-send-email-al.stone@linaro.org>
 <1387239401-13918-2-git-send-email-al.stone@linaro.org>
 <20131227045848.GB21429@srcf.ucam.org>
Message-ID: <52CB306F.1020201@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/26/2013 09:58 PM, Matthew Garrett wrote:
> On Mon, Dec 16, 2013 at 05:16:37PM -0700, al.stone at linaro.org wrote:
>
>> +config ACPI_REDUCED_HARDWARE
>> +	bool "Hardware-reduced ACPI support"
>> +	depends on ARM || ARM64
>> +	help
>> +	This config adds support for Hardware-reduced ACPI.
>
> Well, that's not really true - most of the hardware-reduced ACPI support
> seems to be built even if this isn't turned on. Maybe
> ACPI_REDUCED_HARDWARE_ONLY ?
>

Aha.  Good point; semantically, it is unclear as is.  I'll clarify
and re-submit.

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Linaro Enterprise Group
al.stone at linaro.org
-----------------------------------
