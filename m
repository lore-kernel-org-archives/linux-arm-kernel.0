From: tj@kernel.org (Tejun Heo)
Date: Mon, 14 Apr 2014 13:50:37 -0400
Subject: [PATCH v2] pata_arasan_cf: fix ata_host_activate() failure
 handling
In-Reply-To: <1706948.xQXQIMFS2B@amdc1032>
References: <1706948.xQXQIMFS2B@amdc1032>
Message-ID: <20140414175037.GA15249@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 14, 2014 at 06:01:47PM +0200, Bartlomiej Zolnierkiewicz wrote:
> Add missing cf_exit() and clk_put() calls to ata_host_activate()
> failure path.
> 
> Cc: Viresh Kumar <viresh.linux@gmail.com>
> Cc: Shiraz Hashim <shiraz.hashim@st.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Applied to libata/for-3.15-fixes.

Thanks.

-- 
tejun
