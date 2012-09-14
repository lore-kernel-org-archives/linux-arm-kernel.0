From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Fri, 14 Sep 2012 22:09:36 +0400
Subject: [PATCH 2/8] gpio: pl061 depends on ARM
In-Reply-To: <1347639843-32119-3-git-send-email-dciminaghi@mail.gnudd.com>
References: <1347639843-32119-1-git-send-email-dciminaghi@mail.gnudd.com>
 <1347639843-32119-3-git-send-email-dciminaghi@mail.gnudd.com>
Message-ID: <505372E0.1040906@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 09/14/2012 08:23 PM, Davide Ciminaghi wrote:

> From: Alessandro Rubini <rubini@gnudd.com>

> Patch dece904d itroduced chained_irq_enter/exit, which is only

  Rather commit dece904d. And you need to also specify its summary in parens.

> available for arch/arm and the driver won't compile elsewhere.

> The dependency is thus made explicit, because AMBA is used in the x86
> world by a PCI-to-AMBA bridge, to be submitted.

> Signed-off-by: Alessandro Rubini <rubini@gnudd.com>
> Acked-by: Giancarlo Asnaghi <giancarlo.asnaghi@st.com>

WBR, Sergei
