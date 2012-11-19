From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Mon, 19 Nov 2012 16:42:36 +0400
Subject: [PATCH] ARM: gic: Fix sparse warning
In-Reply-To: <1353322736-2747-1-git-send-email-tushar.behera@linaro.org>
References: <1353322736-2747-1-git-send-email-tushar.behera@linaro.org>
Message-ID: <50AA293C.9010908@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 19-11-2012 14:58, Tushar Behera wrote:

> gic_irq_domain_ops is only used in this file, so should be marked as
> static.

> Fixes following compilation warning.

   This is sparse's warning, not compiler's, if I don't mistake.

> arch/arm/common/gic.c:638:29: warning: symbol 'gic_irq_domain_ops' was
> not declared. Should it be static?

> Signed-off-by: Tushar Behera <tushar.behera@linaro.org>

WBR, Sergei
