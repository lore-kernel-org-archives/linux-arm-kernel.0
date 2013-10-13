From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sun, 13 Oct 2013 11:19:45 +0200
Subject: [PATCH 2/2] ARM: at91: cpuidle: Move driver to drivers/cpuidle
In-Reply-To: <1381593099-1184-2-git-send-email-daniel.lezcano@linaro.org>
References: <1381593099-1184-1-git-send-email-daniel.lezcano@linaro.org>
 <1381593099-1184-2-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <20131013111945.0251a3cc@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Daniel Lezcano,

On Sat, 12 Oct 2013 17:51:39 +0200, Daniel Lezcano wrote:

> +config ARM_AT91_CPUIDLE
> +        bool "Cpu Idle Driver for the AT91 processors"

Nitpick: indentation is done with spaces here, while it should be one
tab.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
