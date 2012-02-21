From: msalter@redhat.com (Mark Salter)
Date: Tue, 21 Feb 2012 10:47:55 -0500
Subject: [PATCH v5 20/27] irq_domain/c6x: constify irq_domain structures
In-Reply-To: <1329383368-12122-21-git-send-email-grant.likely@secretlab.ca>
References: <1329383368-12122-1-git-send-email-grant.likely@secretlab.ca>
 <1329383368-12122-21-git-send-email-grant.likely@secretlab.ca>
Message-ID: <1329839277.17322.4.camel@deneb.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2012-02-16 at 02:09 -0700, Grant Likely wrote:
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> Cc: Mark Salter <msalter@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/arm/common/gic.c            |    2 +-
>  arch/c6x/kernel/irq.c            |    2 +-
>  arch/c6x/platforms/megamod-pic.c |    2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

For c6x part:

Acked-by: Mark Salter <msalter@redhat.com>
