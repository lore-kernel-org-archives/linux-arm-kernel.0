From: andy@warmcat.com (Andy Green)
Date: Mon, 15 Feb 2010 11:58:18 +0100
Subject: [PATCH] imx-serial-excessive-status-clearing-on-break.patch
In-Reply-To: <20100201122853.21848.90945.stgit@otae.warmcat.com>
References: <20100201122853.21848.90945.stgit@otae.warmcat.com>
Message-ID: <4B7928CA.8050408@warmcat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/01/10 13:28, Somebody in the thread at some point said:

> -			writel(temp | USR2_BRCD, sport->port.membase + USR2);
> +			writel(USR2_BRCD, sport->port.membase + USR2);

Hi Sascha -

What is the disposition of this patch?  It solves a real problem in the 
imx serial but it is just sitting there for two weeks.

-Andy
