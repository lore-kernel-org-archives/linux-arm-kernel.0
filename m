From: pramod.gurav.etc@gmail.com (pramod gurav)
Date: Thu, 17 Jul 2014 16:21:33 +0530
Subject: [PATCH 1/3] mfd: qpnp-spmi: add support for Qualcomm QPNP PMICs
In-Reply-To: <CAMf-jSk5+c1QYfKfjqmstB60bM3adK5tgAYwmPKhOi6cSeM_WA@mail.gmail.com>
References: <1404834869-23049-1-git-send-email-svarbanov@mm-sol.com>
 <1404834869-23049-2-git-send-email-svarbanov@mm-sol.com>
 <CAMf-jSk5+c1QYfKfjqmstB60bM3adK5tgAYwmPKhOi6cSeM_WA@mail.gmail.com>
Message-ID: <CAMf-jSkxEmCeKDfw+=+QwgLHz7wYdWJB9qk1bi1gzP7Qpw-6jQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 17, 2014 at 4:18 PM, pramod gurav
<pramod.gurav.etc@gmail.com> wrote:
> +Mark Brown
> Hi Josh/Stanimir,
>
>
> On Tue, Jul 8, 2014 at 9:24 PM, Stanimir Varbanov <svarbanov@mm-sol.com> wrote:
>> From: Josh Cartwright <joshc@codeaurora.org>
>>
>> The Qualcomm QPNP PMIC chips are components used with the
>> Snapdragon 800 series SoC family.  This driver exists
> .
> [SNIP]
> .
>> +config MFD_QPNP_SPMI
>> +       tristate "Qualcomm QPNP SPMI PMIC"
>> +       depends on ARCH_QCOM || COMPILE_TEST
>> +       depends on OF
>> +       select MFD_CORE
>> +       select REGMAP_SPMI
> REGMAP_SPMI use SPMI functions.
>
> https://patchwork.kernel.org/patch/4566591/

Sorry for incomplete comment as I sent the mail by mistake.
In above patchwork discussion Mark Brown suggested "driver using
REGMAP_SPMI should depend on SPMI and select REGMAP_SPMI, assuming
SPMI is a user-selectable Kconfig symbol."

>> +       help
>> +         This enables support for the Qualcomm QPNP SPMI PMICs.
>> +         These PMICs are currently used with the Snapdragon 800 series of
>> +         SoCs.  Note, that this will only be useful paired with descriptions
> .
>
> --
> Thanks and Regards
> Pramod



-- 
Thanks and Regards
Pramod
