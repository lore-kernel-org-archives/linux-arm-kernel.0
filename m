From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Tue, 27 Mar 2012 16:12:05 +0400
Subject: [PATCH] amba-pl011: fix panic introduced by "clear pending
 interrupts"
In-Reply-To: <20120326203209.GA8182@mail.gnudd.com>
References: <20120326203209.GA8182@mail.gnudd.com>
Message-ID: <4F71AE95.9080600@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 27-03-2012 0:32, Alessandro Rubini wrote:

> patch 9b96fba, currently in linux-next, clears interrupts using

    Please also specify the summary of this commit in parens.

> uap->port.membase that has not been assigned.  My x86 system,
> that uses a pci-to-amba bridge, panics with a message like:

>     BUG: unable to handle kernel NULL pointer dereference at 00000038
>     IP: [<c12c85ed>] pl011_probe+0x119/0x303

> Signed-off-by: Alessandro Rubini<rubini@gnudd.com>
> Acked-by: Giancarlo Asnaghi<giancarlo.asnaghi@st.com>

WBR, Sergei
