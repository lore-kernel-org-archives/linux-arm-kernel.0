From: mchitale@apm.com (Mayuresh Chitale)
Date: Thu, 21 Sep 2017 13:26:25 +0530
Subject: [PATCH] tee: ACPI support for optee driver
In-Reply-To: <59C36E18.1050106@huawei.com>
References: <1505977937-25034-1-git-send-email-mchitale@apm.com>
 <59C36E18.1050106@huawei.com>
Message-ID: <CAL-zptMBRAM1-fWVv0u_YP7bhzagDPGOZPNWw5BJmfMdzhutjw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 21, 2017 at 1:15 PM, Hanjun Guo <guohanjun@huawei.com> wrote:
> On 2017/9/21 15:12, Mayuresh Chitale wrote:
>> This patch modifies the optee driver to add support for parsing
>> the conduit method from an ACPI node.
>
> Sorry I didn't involve this earlier, but I think this is a wrong
> approach, in ACPI 5.1+ spec, there is a bit in FADT table which
> indicates PSCI using SMC or HVC, please see ACPI 6.2 [1],
> Table 5-37 Fixed ACPI Description Table ARM Boot Architecture Flags.
>
> Can we just use that to get the conduit method for optee driver too?
Thanks for the comment. I will check it out.
>
> [1]: http://www.uefi.org/sites/default/files/resources/ACPI_6_2.pdf
>
> Thanks
> Hanjun
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
