From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Thu, 11 Dec 2014 11:36:39 +0100
Subject: [RFC PATCH 1/2] pm: Add PM domain notifications
In-Reply-To: <1418286387-9663-2-git-send-email-tfiga@chromium.org>
References: <1418286387-9663-1-git-send-email-tfiga@chromium.org>
 <1418286387-9663-2-git-send-email-tfiga@chromium.org>
Message-ID: <548973B7.3050107@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz,

On 11/12/14 09:26, Tomasz Figa wrote:
> From: Sylwester Nawrocki <s.nawrocki@samsung.com>
> 
> This patch adds notifiers to the runtime PM/genpd subsystem. It is now
> possible to register a notifier, which will be called before and after
> the generic power domain subsystem calls the power domain's power_on
> and power_off callbacks.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> [tfiga at chromium.org: rebased]
> Signed-off-by: Tomasz Figa <tfiga@chromium.org>

Not sure if you've noticed it, I posted an updated version of this patch
recently [1]. The notifiers list is moved to struct generic_pm_domain
there and it also allows to register a notifier for selected power domain
by name.

-- 
Regards,
Sylwester

[1] http://www.spinics.net/lists/linux-samsung-soc/msg38549.html
