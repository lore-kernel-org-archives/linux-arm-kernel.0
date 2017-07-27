From: rafael@kernel.org (Rafael J. Wysocki)
Date: Thu, 27 Jul 2017 17:09:42 +0200
Subject: [PATCH v6 1/1] acpi: apei: Enable APEI multiple GHES source to
 share a single external IRQ
In-Reply-To: <20170727144922.GF28553@nazgul.tnic>
References: <1500661477-6536-1-git-send-email-lho@apm.com>
 <20170722055954.GA2082@nazgul.tnic>
 <1893763.BLgt1zgLk5@aspire.rjw.lan> <1632667.Vgem7HtdXu@aspire.rjw.lan>
 <20170727055825.GA4611@nazgul.tnic>
 <CAJZ5v0jVSrsufoWyexb_MWS=ni0CDn7Oo1-oHOcaTxdYpfpQMg@mail.gmail.com>
 <20170727144922.GF28553@nazgul.tnic>
Message-ID: <CAJZ5v0gQ5aYZw8NOpvmw-1zqfFg_k+nkTZxEocnT=hDk37VsGA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 27, 2017 at 4:49 PM, Borislav Petkov <bp@suse.de> wrote:
> On Thu, Jul 27, 2017 at 04:34:59PM +0200, Rafael J. Wysocki wrote:
>> I can collect it, no problem.
>>
>> So from now on I will pick up APEI things with ACKs from you or Tony.
>
> If you agree with that, that is. But we kinda do that already, more or
> less. :-)
>
> Then I guess we should add something like this so that get_maintainer
> finds us:
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f66488dfdbc9..985413fb5d83 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -310,6 +310,14 @@ F: drivers/pci/*/*acpi*
>  F:     drivers/pci/*/*/*acpi*
>  F:     tools/power/acpi/
>
> +ACPI APEI
> +M:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
> +M:     Len Brown <lenb@kernel.org>
> +L:     linux-acpi at vger.kernel.org
> +R:     Tony Luck <tony.luck@intel.com>
> +R:     Borislav Petkov <bp@alien8.de>
> +F:     drivers/acpi/apei/
> +
>  ACPI COMPONENT ARCHITECTURE (ACPICA)
>  M:     Robert Moore <robert.moore@intel.com>
>  M:     Lv Zheng <lv.zheng@intel.com>
>
> ---
>
> Provided Tony agrees though... I'd venture a guess and say that he
> doesn't have a choice, woahahhahaha...
>
> :-)))

Well, I guess send this officially with a CC:Tony and see what he says. :-)
