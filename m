From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 29 Jul 2017 22:15:14 +0300
Subject: [PATCH] pinctrl-st: fix of_irq_to_resource() result check
In-Reply-To: <20170729180744.873303067@cogentembedded.com>
References: <20170729180744.873303067@cogentembedded.com>
Message-ID: <4c03d43e-b10e-77bc-841e-f98a13d0d84c@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/29/2017 09:07 PM, Sergei Shtylyov wrote:

> of_irq_to_resource() has recently been fixed to return negative error #'s
> along with 0 in case of failure, however the ST driver still only regards
> 0 as failure indication -- fix it up.
>
> Fixes: 7a4228bbff76 ("of: irq: use of_irq_get() in of_irq_to_resource()")
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
[...]

    Forgot to mention that the patch is against the 'fixes' branch of Linus 
W.'s 'linux-pinctrl.git' repo.

MBR, Sergei
