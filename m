From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 29 Nov 2017 16:18:05 +0000
Subject: [PATCH v1 0/2] Additional single-step-cases
In-Reply-To: <20171123121134.11050-1-alex.bennee@linaro.org>
References: <20171123121134.11050-1-alex.bennee@linaro.org>
Message-ID: <25e0999c-df1a-b25c-6b56-6a63ebcb690d@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/11/17 12:11, Alex Benn?e wrote:
> Hi,
> 
> This is now split into two patches as the first case of SError is
> separate from behaviour of stepping instructions.
> 
> Alex Benn?e (2):
>   kvm: arm64: handle single-step during SError exceptions
>   kvm: arm64: handle single-step of hyp emulated mmio instructions
> 
>  arch/arm64/kvm/handle_exit.c |  8 +++++++-
>  arch/arm64/kvm/hyp/switch.c  | 37 ++++++++++++++++++++++++++++++-------
>  2 files changed, 37 insertions(+), 8 deletions(-)
> 

For both patches:

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
