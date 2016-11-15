From: rafael@kernel.org (Rafael J. Wysocki)
Date: Tue, 15 Nov 2016 14:04:09 +0100
Subject: [PATCH v7 00/16] ACPI IORT ARM SMMU support
In-Reply-To: <20161115101257.GB16261@red-moon>
References: <20161109141948.19244-1-lorenzo.pieralisi@arm.com>
 <CAJZ5v0j09fsp4Y66v2UANOGnW4FNO7PWxpZY=Pgw=bUccEL_eA@mail.gmail.com>
 <20161115101257.GB16261@red-moon>
Message-ID: <CAJZ5v0gh9qB41zcnvnETDA-5ho577uhxE4rehZqEXorFViY__w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 15, 2016 at 11:12 AM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> Hi Rafael,
>
> On Thu, Nov 10, 2016 at 12:36:12AM +0100, Rafael J. Wysocki wrote:
>> Hi Lorenzo,
>>
>> On Wed, Nov 9, 2016 at 3:19 PM, Lorenzo Pieralisi
>> <lorenzo.pieralisi@arm.com> wrote:
>> > This patch series is v7 of a previous posting:
>> >
>> > https://lkml.org/lkml/2016/10/18/506
>>
>> I don't see anything objectionable in this series.
>>
>> Please let me know which patches in particular to look at in detail.
>
> Are patches 7 and consequently 16 (that builds on top of 7) ok with
> you ? They should be equivalent to nop on anything other than ARM64
> but they touch ACPI core so they require an ACK if they are ok please.

Yes, they are.  Please feel free to add my ACKs to those or I will
send them separately later today.

Thanks,
Rafael
