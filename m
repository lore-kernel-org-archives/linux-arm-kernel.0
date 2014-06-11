From: khilman@linaro.org (Kevin Hilman)
Date: Wed, 11 Jun 2014 11:23:07 -0700
Subject: [PATCH 00/24] PM / Domains: Generic OF-based support and cleanups
In-Reply-To: <1402397497-26737-1-git-send-email-ulf.hansson@linaro.org> (Ulf
 Hansson's message of "Tue, 10 Jun 2014 12:51:13 +0200")
References: <1402397497-26737-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <7hlht3gvas.fsf@paris.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ulf Hansson <ulf.hansson@linaro.org> writes:

> Parts of this patchset has been posted earlier. To be able to smoothly continue
> my work in re-factoring genpd I have collected patches into this patchset.
>
> The complete patchset is available at the linux-pm_linux-next_genpd branch at:
> git.linaro.org/people/ulf.hansson/linux-2.6.git
> This branch is based upon Rafael's linux-pm tree's linux-next branch.
>
> And important note. There are dependencies througout this patchset, which means
> the all need to go together. I suggest we use Rafael's tree, thus I seek for
> acks from the affected ARM SoC maintainers.

At least on the surface, there are at least 3 separate series going on
here

1) DT support for genpd
2) various genpd cleanups
3) ux500 support

Clearly they are related, but it would be easier to review if a large
series like this is broken up into smaller series where the cover
letters describe the dependencies between them

Kevin
