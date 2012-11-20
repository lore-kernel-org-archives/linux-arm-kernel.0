From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Tue, 20 Nov 2012 17:00:48 +0400
Subject: [PATCH] ARM: gic: Fix sparse warning
In-Reply-To: <50AAF84E.5080900@linaro.org>
References: <1353322736-2747-1-git-send-email-tushar.behera@linaro.org>
 <50AA293C.9010908@mvista.com> <50AAF84E.5080900@linaro.org>
Message-ID: <50AB7F00.4010105@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20-11-2012 7:26, Tushar Behera wrote:

>>> gic_irq_domain_ops is only used in this file, so should be marked as
>>> static.

>>> Fixes following compilation warning.

>>    This is sparse's warning, not compiler's, if I don't mistake.

> My mistake. It is indeed sparse warning.

    And I didn't read your subject, where it's called correctly. :-)

>>> arch/arm/common/gic.c:638:29: warning: symbol 'gic_irq_domain_ops' was
>>> not declared. Should it be static?

>>> Signed-off-by: Tushar Behera <tushar.behera@linaro.org>

WBR, Sergei
