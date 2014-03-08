From: oleg@redhat.com (Oleg Nesterov)
Date: Sat, 8 Mar 2014 16:29:08 +0100
Subject: [PATCH v7 01/15] uprobes: Kconfig dependency fix
In-Reply-To: <1394223040-17129-2-git-send-email-dave.long@linaro.org>
References: <1394223040-17129-1-git-send-email-dave.long@linaro.org>
 <1394223040-17129-2-git-send-email-dave.long@linaro.org>
Message-ID: <20140308152908.GA19605@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/07, David Long wrote:
>
> From: "David A. Long" <dave.long@linaro.org>
>
> Suggested change from Oleg Nesterov.

Actually this was suggested by Srikar ;) I hope he won't mind.

> Fixes incomplete dependencies
> for uprobes feature.

Acked-by: Oleg Nesterov <oleg@redhat.com>



Once this change is merged I'll try to untangle UPROBES and PERF.
Perhaps we should change Makefiles as Russell suggests, or we can
simply move uprobes.c to kernel/.

Oleg.
