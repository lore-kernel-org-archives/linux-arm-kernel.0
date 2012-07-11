From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 12 Jul 2012 00:19:18 +0200 (CEST)
Subject: [RFC PATCH 2/2] irq: add irq_desc_initialize to remove some
 duplicated lines
In-Reply-To: <1340182831-10477-2-git-send-email-b29396@freescale.com>
References: <1340182831-10477-1-git-send-email-b29396@freescale.com>
 <1340182831-10477-2-git-send-email-b29396@freescale.com>
Message-ID: <alpine.LFD.2.02.1207120017590.32033@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 20 Jun 2012, Dong Aisheng wrote:
> From: Dong Aisheng <dong.aisheng@linaro.org>
> 
> There're two copies of irq_desc initialization code, reform them into
> an irq_desc_initialize function to call.
> 
> Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
> ---
>  kernel/irq/irqdesc.c |   51 +++++++++++++++++++++++++++----------------------
>  1 files changed, 28 insertions(+), 23 deletions(-)

We add more code by removing redundant copies?
