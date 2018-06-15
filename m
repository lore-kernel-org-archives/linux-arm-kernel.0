From: alex.bennee@linaro.org (Alex =?utf-8?Q?Benn=C3=A9e?=)
Date: Fri, 15 Jun 2018 09:50:54 +0100
Subject: [PATCH 4/4] KVM: arm64: Avoid mistaken attempts to save SVE state
 for vcpus
In-Reply-To: <1528976546-25999-4-git-send-email-Dave.Martin@arm.com>
References: <1528976039-25826-1-git-send-email-Dave.Martin@arm.com>
 <1528976546-25999-1-git-send-email-Dave.Martin@arm.com>
 <1528976546-25999-4-git-send-email-Dave.Martin@arm.com>
Message-ID: <87po0szb4h.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Dave Martin <Dave.Martin@arm.com> writes:
> This patch ensures this my delaying restoration of current's
> TIF_SVE until after the call to fpsimd_save().

this *by* delaying

--
Alex Benn?e
