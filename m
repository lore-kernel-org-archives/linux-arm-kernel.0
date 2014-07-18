From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 18 Jul 2014 09:49:01 +0530
Subject: [PATCH v3 1/2] cpufreq: Don't destroy/realloc policy/sysfs on
 hotplug/suspend
In-Reply-To: <53C8938F.1070706@codeaurora.org>
References: <1405464473-3916-1-git-send-email-skannan@codeaurora.org>
 <1405464473-3916-2-git-send-email-skannan@codeaurora.org>
 <CAKohpok2hzwDLy77CZJ+7pHV-Nj4XTviJxVeXQYJRYtKXME00w@mail.gmail.com>
 <53C65F03.1050609@mit.edu> <53C6D8EC.1030609@codeaurora.org>
 <CAKohpongsNtEVbHL=w1fbw5tEXK=WaMcp1N03ar9Sx_CU=1O-w@mail.gmail.com>
 <53C8938F.1070706@codeaurora.org>
Message-ID: <CAKohpo=puU-AifGAXMAOs1pnyvTk64u-Fkra5i=-QNn_a-isXQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18 July 2014 08:55, Saravana Kannan <skannan@codeaurora.org> wrote:
> Not really. We much never do it during hotplug. We only do it when the
> cpufreq driver unregisters.

Oh yes.
