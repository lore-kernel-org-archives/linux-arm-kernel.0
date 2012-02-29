From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Wed, 29 Feb 2012 21:04:02 +0530
Subject: [PATCHv3 0/4] ARM: OMAP4: core retention support
In-Reply-To: <1330529106-10423-1-git-send-email-t-kristo@ti.com>
References: <1330529106-10423-1-git-send-email-t-kristo@ti.com>
Message-ID: <CAMQu2gwHrqxZtij2mO3fgh7e8Hqr7ZTMzLxEboeT0pGK2siMOg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 29, 2012 at 8:55 PM, Tero Kristo <t-kristo@ti.com> wrote:
> Hi,
>
> Changes compared to previous version:
>
> - split out the io_chain set as a separate set
> - marked patch 3 as TEMP, this is only needed until Paul's pwrdm fixes
> ?get merged (http://marc.info/?l=linux-omap&m=133040749621183&w=2)
>
> Depends on the io_chain set to provide wakeup capability from
> retention.
>
> Tested with omap4430 blaze : suspend / resume works okay.

Thanks for fixing answering the comments on last version.
For entire series you can add
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
