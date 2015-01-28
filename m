From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 28 Jan 2015 11:06:53 +0100
Subject: [PATCH 1/8] PM / Domains: Rename __pm_genpd_alloc|free_dev_data()
In-Reply-To: <1422389625-11730-2-git-send-email-ulf.hansson@linaro.org>
References: <1422389625-11730-1-git-send-email-ulf.hansson@linaro.org>
 <1422389625-11730-2-git-send-email-ulf.hansson@linaro.org>
Message-ID: <20150128100653.GB29177@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 2015-01-27 21:13:38, Ulf Hansson wrote:
> In a step to get consistent names of functions in genpd, rename
> the internal __pm_genpd_alloc|free_dev_data() into
> gendp_alloc|free_dev_data().
> 
> As discussed on the linux-pm list, let's move towards the following
> name rules:
> 
> Internal functions:
> genpd_*
> _genpd_*
> __genpd_*
> 
> External functions:
> pm_genpd_*
> _pm_genpd_*
> __pm_genpd_*
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Acked-by: Pavel Machek <pavel@ucw.cz>


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
