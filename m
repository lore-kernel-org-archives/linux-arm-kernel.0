From: anup.patel@linaro.org (Anup Patel)
Date: Sat, 22 Mar 2014 09:30:44 +0530
Subject: [PATCH v5 01/11] KVM: Add capability to advertise PSCI v0.2
 support
In-Reply-To: <20140321232201.GA25519@cbox>
References: <1395406414-11707-1-git-send-email-anup.patel@linaro.org>
 <1395406414-11707-2-git-send-email-anup.patel@linaro.org>
 <20140321232201.GA25519@cbox>
Message-ID: <CALrVBkt9XgTQZNarSCGNy6avDAQqch5No=OXiwL4L2VuMjHmjA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 March 2014 04:52, Christoffer Dall <christoffer.dall@linaro.org> wrote:
> On Fri, Mar 21, 2014 at 06:23:24PM +0530, Anup Patel wrote:
>> User space (i.e. QEMU or KVMTOOL) should be able to check whether KVM
>> ARM/ARM64 supports in-kernel PSCI v0.2 emulation. For this purpose, we
>> define KVM_CAP_ARM_PSCI_0_2 in KVM user space interface header.
>>
>> Signed-off-by: Anup Patel <anup.patel@linaro.org>
>> Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
>
> Please add the acked-by tags when people give them to you - otherwise it's a
> bit of a wasted effort and I have to go back and check so I don't review
> the patches again.

OK.

>
> Thanks,
> -Christoffer
