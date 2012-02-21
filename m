From: msalter@redhat.com (Mark Salter)
Date: Tue, 21 Feb 2012 10:48:33 -0500
Subject: [PATCH v5 21/27] irq_domain/c6x: Use library of xlate functions
In-Reply-To: <1329383368-12122-22-git-send-email-grant.likely@secretlab.ca>
References: <1329383368-12122-1-git-send-email-grant.likely@secretlab.ca>
 <1329383368-12122-22-git-send-email-grant.likely@secretlab.ca>
Message-ID: <1329839315.17322.5.camel@deneb.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2012-02-16 at 02:09 -0700, Grant Likely wrote:
> The c6x irq controllers don't need to define custom .xlate hooks
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Mark Salter <msalter@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/c6x/kernel/irq.c            |    1 +
>  arch/c6x/platforms/megamod-pic.c |   14 +-------------
>  2 files changed, 2 insertions(+), 13 deletions(-)

Acked-by: Mark Salter <msalter@redhat.com>
