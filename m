From: drjones@redhat.com (Andrew Jones)
Date: Thu, 17 Sep 2015 11:30:07 +0200
Subject: [PATCH v2 00/22] KVM: ARM64: Add guest PMU support
In-Reply-To: <55FA1832.3040008@linaro.org>
References: <1441961715-11688-1-git-send-email-zhaoshenglong@huawei.com>
 <55F9D9FC.6010905@redhat.com> <55FA1832.3040008@linaro.org>
Message-ID: <20150917093007.GB5933@hawk.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 17, 2015 at 09:32:34AM +0800, Shannon Zhao wrote:
> Hi Wei,
> 
> On 2015/9/17 5:07, Wei Huang wrote:
> > I am testing this series. 
> Thanks for your time and help.
> 
> > The first question is: do you plan to add ACPI
> > support in QEMU?
> To the completeness, this should be added. Maybe this could be added at
> v3. But I have a look at the kernel PMU driver, it doesn't support
> probing through ACPI, although there are some patches[1] out-of-tree.
> 
> > My in-house kernel uses ACPI for device probing. I had
> > to force "acpi=off" when I test this patch series.
> Guest kernel only boots with ACPI when you add "acpi=force". No need to
> add "acpi=off".

The Red Hat kernel uses ACPI by default, when tables are present (Thanks
again for your QEMU table generation patches!)

drew

> 
> Thanks,
> 
> [1] http://marc.info/?l=linaro-acpi&m=137949337925645&w=2
> -- 
> Shannon
> _______________________________________________
> kvmarm mailing list
> kvmarm at lists.cs.columbia.edu
> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
