From: khilman@kernel.org (Kevin Hilman)
Date: Wed, 23 Sep 2015 10:59:04 -0700
Subject: [PATCH] ARM: OMAP2+: PM: Denote the cpuidle tracepoints as
 _rcuidle()
In-Reply-To: <1442554881-706-1-git-send-email-jszhang@marvell.com> (Jisheng
 Zhang's message of "Fri, 18 Sep 2015 13:41:21 +0800")
References: <1442554881-706-1-git-send-email-jszhang@marvell.com>
Message-ID: <7hfv25dnkn.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jisheng Zhang <jszhang@marvell.com> writes:

> The cpuidle tracepoints are called within a rcu_idle_exit() section, and
> must be denoted with the _rcuidle() version of the tracepoint.
>
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
 
Acked-by: Kevin Hilman <khilman@linaro.org>
