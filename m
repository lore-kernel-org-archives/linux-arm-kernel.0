From: jangra.pankaj9@gmail.com (Pankaj Jangra)
Date: Fri, 22 Jun 2012 21:27:44 +0530
Subject: [PATCH 06/11] gpio/omap: add clk_prepare and clk_unprepare
In-Reply-To: <1340372890-10091-7-git-send-email-rnayak@ti.com>
References: <1340372890-10091-1-git-send-email-rnayak@ti.com>
 <1340372890-10091-7-git-send-email-rnayak@ti.com>
Message-ID: <CADTbHxrWwYQK+ei7yy7RYuD1dvHg2mL-yajLnzwjg=h=UzBt3w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HI,

On Fri, Jun 22, 2012 at 7:18 PM, Rajendra Nayak <rnayak@ti.com> wrote:
> In preparation of OMAP moving to Common Clk Framework(CCF) add clk_prepare()
> for omap gpio debounce clock.
>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> ---
> ?drivers/gpio/gpio-omap.c | ? ?2 ++
> ?1 files changed, 2 insertions(+), 0 deletions(-)

Reviewed-by: Pankaj Jangra <jangra.pankaj9@gmail.com>

Regards,
Pankaj Jangra
