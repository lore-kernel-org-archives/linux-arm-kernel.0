From: davem@davemloft.net (David Miller)
Date: Thu, 28 Jun 2012 17:03:49 -0700 (PDT)
Subject: [PATCH] davinci_cpdma: include linux/module.h
In-Reply-To: <1340899952-15201-1-git-send-email-zonque@gmail.com>
References: <1340899952-15201-1-git-send-email-zonque@gmail.com>
Message-ID: <20120628.170349.745871140804161480.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Daniel Mack <zonque@gmail.com>
Date: Thu, 28 Jun 2012 18:12:32 +0200

> This fixes a number of warnings such as:
> 
>   CC      drivers/net/ethernet/ti/davinci_cpdma.o
> drivers/net/ethernet/ti/davinci_cpdma.c:279:1: warning: data definition
> has no type or storage class
> drivers/net/ethernet/ti/davinci_cpdma.c:279:1: warning: type defaults to
> ?int? in declaration of ?EXPORT_SYMBOL_GPL?
> drivers/net/ethernet/ti/davinci_cpdma.c:279:1: warning: parameter names
> (without types) in function declaration
> 
> Signed-off-by: Daniel Mack <zonque@gmail.com>

Applied, thanks.
