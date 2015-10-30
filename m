From: dhdang@apm.com (Duc Dang)
Date: Fri, 30 Oct 2015 09:53:53 -0700
Subject: [PATCH V3 0/6] gicv2m: acpi: Add ACPI support for GICv2m MSI
In-Reply-To: <563378CB.9090005@amd.com>
References: <1445453249-32557-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <CADaLNDnhn+Lax6aMseA4kPsAfKHG=L0buO6Tf-U8sxfUzn38BA@mail.gmail.com>
 <563378CB.9090005@amd.com>
Message-ID: <CADaLND=g=Md5YzALGQbtUHYVUSyCcAgLwJ1vAR+7mDDOdDm=_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 30, 2015 at 7:03 AM, Suravee Suthikulpanit
<Suravee.Suthikulpanit@amd.com> wrote:
> Hi Duc
>
> On 10/29/15 16:25, Duc Dang wrote:
>>
>> Hi Suravee,
>> On Wed, Oct 21, 2015 at 11:47 AM, Suravee Suthikulpanit
>> <Suravee.Suthikulpanit@amd.com>  wrote:
>>>
>>> >This patch series has been forked from the following patch series since
>>> >it no longer depends on the rest of the patches.
>>> >
>>> >   [PATCH v4 00/10] ACPI GIC Self-probing, GICv2m and GICv3 support
>>> >   https://lkml.org/lkml/2015/7/29/234
>>> >
>>> >It has been ported to use the newly introduced device fwnode_handle
>>> >for ACPI irqdmain introduced by Marc in the following patch series:
>>> >
>>> >   [PATCH v2 00/17] Divorcing irqdomain and device_node
>>> >   http://git.kernel.org/cgit/linux/kernel/git/maz/arm-platforms.git
>>> > irq/irq-domain-fwnode-v2
>>> >
>>> >The following git branch contains the submitted patches along with
>>> >the pre-requsite patches (mainly for ARM64 PCI support for ACPI).
>>> >
>>> >   https://github.com/ssuthiku/linux.git  v2m-multiframe-v3
>>
>> I tried to clone your tree to test on my X-Gene platform but I didn't
>> see branch v2m-multiframe-v3.
>> I see similar patch set in origin/irq-domain-fwnode-v2-v2m-multiframe.
>> Can you please check?
>>
>
> It should be there now. I might have forgotten to push it to my Github.
> Sorry for inconvenience, and thanks for testing.

Thanks Suravee. I see branch v2m-multiframe-v3 now. I will test and
update you soon.

>
> Suravee

Regards,
Duc Dang.
