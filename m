From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 14 Apr 2014 21:43:47 +0530
Subject: [PATCH v2] pata_arasan_cf: fix ata_host_activate() failure
 handling
In-Reply-To: <1706948.xQXQIMFS2B@amdc1032>
References: <1706948.xQXQIMFS2B@amdc1032>
Message-ID: <CAOh2x=nQWZbYdbKpkVaXhRjTKq++GMujO+aFEBgLLyrEtsCPew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 14, 2014 at 9:31 PM, Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
> Add missing cf_exit() and clk_put() calls to ata_host_activate()
> failure path.
>
> Cc: Viresh Kumar <viresh.linux@gmail.com>
> Cc: Shiraz Hashim <shiraz.hashim@st.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
> v2:
> - re-order code and then drop redundant goto statement
>
>  drivers/ata/pata_arasan_cf.c |    7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
