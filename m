From: maz@misterjones.org (Marc Zyngier)
Date: Sun, 22 Jun 2014 12:20:04 +0100
Subject: [RFC PATCH 1/6] arm/arm64: KVM: Rename =?UTF-8?Q?irq=5Fstate?=
 =?UTF-8?Q?=20to=20irq=5Fpending?=
In-Reply-To: <1402779067-34478-2-git-send-email-christoffer.dall@linaro.org>
References: <1402779067-34478-1-git-send-email-christoffer.dall@linaro.org>
 <1402779067-34478-2-git-send-email-christoffer.dall@linaro.org>
Message-ID: <a200e8076ab25013c6fd735fae68b1de@www.loen.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014-06-14 21:51, Christoffer Dall wrote:
> The irq_state field on the distributor struct is ambiguous in its
> meaning; the comment says it's the level of the input put, but that
> doesn't make much sense for edge-triggered interrupts.  The code
> actually uses this state variable to check if the interrupt is in the
> pending state on the distributor so clarify the comment and rename 
> the
> actual variable and accessor methods.
>
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>

Looks good to me.

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

         M.
-- 
Who you jivin' with that Cosmik Debris?
