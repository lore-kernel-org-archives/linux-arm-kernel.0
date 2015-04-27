From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 27 Apr 2015 22:11:36 +0200
Subject: [PATCH] ARM: pxa: Constify irq_domain_ops
In-Reply-To: <1430139046-3618-1-git-send-email-k.kozlowski.k@gmail.com>
 (Krzysztof Kozlowski's message of "Mon, 27 Apr 2015 21:50:46 +0900")
References: <1430139046-3618-1-git-send-email-k.kozlowski.k@gmail.com>
Message-ID: <87egn5jpqf.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Krzysztof Kozlowski <k.kozlowski.k@gmail.com> writes:

> The irq_domain_ops are not modified by the driver and the irqdomain core
> code accepts pointer to a const data.
>
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Applied to pxa/for-next, thanks !

The hunk will move a bit in the file as pxa/fixes branch moves the place of this
pxa_irq_ops declaration within the file, but nevertheless the patch will be
there.

Cheers.

-- 
Robert
