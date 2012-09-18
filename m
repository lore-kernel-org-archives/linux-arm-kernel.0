From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Tue, 18 Sep 2012 08:32:09 -0400
Subject: [PATCH 00/15] KVM/ARM Implementation
In-Reply-To: <20120918122111.GI32204@mudshark.cambridge.arm.com>
References: <20120915153359.21241.86002.stgit@ubuntu>
 <20120918122111.GI32204@mudshark.cambridge.arm.com>
Message-ID: <CANM98q+sHjKnEOKwXGtUdOJJp_tobm5ckSzKHhYJfSeWr0k2kw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 18, 2012 at 8:21 AM, Will Deacon <will.deacon@arm.com> wrote:
> Hi Christoffer,
>
> On Sat, Sep 15, 2012 at 04:34:29PM +0100, Christoffer Dall wrote:
>> The following series implements KVM support for ARM processors,
>> specifically on the Cortex A-15 platform.  We feel this is ready to be
>> merged.
>>
>> Work is done in collaboration between Columbia University, Virtual Open
>> Systems and ARM/Linaro.
>>
>> The patch series applies to Linux 3.6-rc5 with a number of merges:
>>  1. git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git
>>         branch: io (fc8a08c3a3a)
>
> This is a rebasing branch. If you want to merge it, I can push a separate
> stable branch for you if you like? That said, I imagine the only patch you
> want from there is the non-writeback I/O accessors, so I could just stick
> that somewhere else until it hits mainline.
>
> Let me know,
>
Hi Will,

I actually merged this branch so Marc could merge from my branches, so
I included it in the base for this patch series as well, to minimize
the diff between the HEAD of kvm-arm-v11-vgic-times and kvm-arm-master
at time of sending these patches out. You don't have to prepare the
patch separately, as the kernel boots just fine without it now when we
have thumb mmio instruction decoding, albeit somewhat slower.

Thanks!
-Christoffer
