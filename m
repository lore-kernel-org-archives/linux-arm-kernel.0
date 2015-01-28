From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 28 Jan 2015 11:07:32 +0100
Subject: [PATCH 2/8] PM / Domains: Remove reference counting for the
 generic_pm_domain_data
In-Reply-To: <1422389625-11730-3-git-send-email-ulf.hansson@linaro.org>
References: <1422389625-11730-1-git-send-email-ulf.hansson@linaro.org>
 <1422389625-11730-3-git-send-email-ulf.hansson@linaro.org>
Message-ID: <20150128100732.GC29177@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 2015-01-27 21:13:39, Ulf Hansson wrote:
> The reference counting was needed when genpd supported PM domain device
> callbacks. Since this option has been removed, let's also remove the
> reference counting of the struct generic_pm_domain_data.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Acked-by: Pavel Machek <pavel@ucw.cz>
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
