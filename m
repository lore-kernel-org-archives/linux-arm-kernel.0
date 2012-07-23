From: florian@openwrt.org (Florian Fainelli)
Date: Mon, 23 Jul 2012 21:14:49 +0200
Subject: Clocksource/clockevent with non self-reloading timer blocks?
Message-ID: <1772014.SXB9lS46ng@bender>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

The SoC I work on (Moschip MCS8140) has several timer blocks, but none of them 
are self-reloading timers, yet I can enable/disable the free-running timer, 
and enable/disable the interrupt generation.

Are there any existing in kernel clocksource/clockevent drivers with the same 
constraints?

Thank you very much for your answer.
-- 
Florian
