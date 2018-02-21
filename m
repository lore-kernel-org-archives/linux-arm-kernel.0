From: drjones@redhat.com (Andrew Jones)
Date: Wed, 21 Feb 2018 18:44:51 +0100
Subject: [PATCH v4 18/40] KVM: arm64: Rewrite sysreg alternatives to
 static keys
In-Reply-To: <20180215210332.8648-19-christoffer.dall@linaro.org>
References: <20180215210332.8648-1-christoffer.dall@linaro.org>
 <20180215210332.8648-19-christoffer.dall@linaro.org>
Message-ID: <20180221174451.4p24h2aqbymrjfqs@kamzik.brq.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 15, 2018 at 10:03:10PM +0100, Christoffer Dall wrote:
> As we are about to move calls around in the sysreg save/restore logic,
> let's first rewrite the alternative function callers, because it is
> going to make the next patches much easier to read.
> 
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> ---
>  arch/arm64/kvm/hyp/sysreg-sr.c | 17 ++++-------------
>  1 file changed, 4 insertions(+), 13 deletions(-)
>

Reviewed-by: Andrew Jones <drjones@redhat.com>
