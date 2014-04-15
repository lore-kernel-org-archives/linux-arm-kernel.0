From: peter.maydell@linaro.org (Peter Maydell)
Date: Tue, 15 Apr 2014 14:07:32 +0100
Subject: [PATCH v9 05/12] ARM/ARM64: KVM: Make kvm_psci_call() return
 convention more flexible
In-Reply-To: <87vbuaye63.fsf@approximate.cambridge.arm.com>
References: <1397542455-354-1-git-send-email-anup.patel@linaro.org>
 <1397542455-354-6-git-send-email-anup.patel@linaro.org>
 <87y4z6zydm.fsf@approximate.cambridge.arm.com>
 <CAAhSdy0hna8NifXXb6icgUEVA_T0Seu99xf6JtGGbsEWYH2+fQ@mail.gmail.com>
 <87vbuaye63.fsf@approximate.cambridge.arm.com>
Message-ID: <CAFEAcA__jNiWnODSna8bLPv9xw4a-YQi=kJcpPivgXMjt+T5gg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 April 2014 13:23, Marc Zyngier <marc.zyngier@arm.com> wrote:
> I understand that, and this is the only case at the moment. What I'm
> foreseeing is a situation where we've been unable to perform the
> expected service, and PSCI doesn't specify any "internal error". So an
> error injection looks like a valid solution to me.

This sounds like a flaw in the PSCI spec which we should
try to get fixed...

thanks
-- PMM
