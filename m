From: alex.bennee@linaro.org (Alex =?utf-8?Q?Benn=C3=A9e?=)
Date: Thu, 24 May 2018 16:02:28 +0100
Subject: [PATCH v10 16/18] KVM: arm64: Remove redundant *exit_code changes
 in fpsimd_guest_exit()
In-Reply-To: <1527005119-6842-17-git-send-email-Dave.Martin@arm.com>
References: <1527005119-6842-1-git-send-email-Dave.Martin@arm.com>
 <1527005119-6842-17-git-send-email-Dave.Martin@arm.com>
Message-ID: <87y3g9rta3.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Dave Martin <Dave.Martin@arm.com> writes:

> In fixup_guest_exit(), there are a couple of cases where after
> checking what the exit code was, we assign it explicitly with the
> value it already had.
>
> Assuming this is not indicative of a bug, these assignments are not
> needed.
>
> This patch removes the redundant assignments, and simplifies some
> if-nesting that becomes trivial as a result.
>
> No functional change.
>
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>

Reviewed-by: Alex Benn?e <alex.bennee@linaro.org>

--
Alex Benn?e
