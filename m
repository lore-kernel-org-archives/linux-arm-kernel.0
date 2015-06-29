From: peter.maydell@linaro.org (Peter Maydell)
Date: Mon, 29 Jun 2015 18:17:51 +0100
Subject: [PATCH] arm64: KVM: Enable minimalistic support for Thunder
In-Reply-To: <55917C31.4060107@arm.com>
References: <1435348284-32132-1-git-send-email-tchalamarla@caviumnetworks.com>
 <55910794.6000107@arm.com>
 <AED13EAB-D578-451F-AC35-A45A21816076@caviumnetworks.com>
 <55917C31.4060107@arm.com>
Message-ID: <CAFEAcA-uDyWko_TA+thCqZ-N8200n9b_ACcSQZvw1QX-PWCLBg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29 June 2015 at 18:11, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 29/06/15 18:06, Chalamarla, Tirumalesh wrote:
>>
>>> On Jun 29, 2015, at 1:53 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>>> Constantly adding new CPUs without providing any insight as to how they
>>> should be emulated only brings churn, and not much benefit.
>>>
>> we are not planning(at this point) to emulate Thunder with QEMU/others.
>
> Fair enough. If cross-cpu VM migration is none of your concern, then
> Suzuki's patch should be enough.

"Emulate with QEMU" is a completely different thing from
"support cross-cpu VM migration" !

-- PMM
