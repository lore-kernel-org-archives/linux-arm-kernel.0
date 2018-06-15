From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 15 Jun 2018 10:27:10 +0100
Subject: [PATCH 4/4] KVM: arm64: Avoid mistaken attempts to save SVE
 state for vcpus
In-Reply-To: <87po0szb4h.fsf@linaro.org>
References: <1528976039-25826-1-git-send-email-Dave.Martin@arm.com>
 <1528976546-25999-1-git-send-email-Dave.Martin@arm.com>
 <1528976546-25999-4-git-send-email-Dave.Martin@arm.com>
 <87po0szb4h.fsf@linaro.org>
Message-ID: <20180615092708.GO22983@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 15, 2018 at 09:50:54AM +0100, Alex Benn?e wrote:
> 
> Dave Martin <Dave.Martin@arm.com> writes:
> > This patch ensures this my delaying restoration of current's
> > TIF_SVE until after the call to fpsimd_save().
> 
> this *by* delaying

No Reviewed-my? ;)

I'll repost for the bh_disable/irqsave changes anyway, so I can fix
typos at low effort.

Cheers
---Dave
