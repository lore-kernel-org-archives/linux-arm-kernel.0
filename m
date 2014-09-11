From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 11 Sep 2014 22:57:17 +0200
Subject: [PATCH v2 5/9] ARM: meson6: clocksource: add Meson6 timer support
In-Reply-To: <1410466300-19168-6-git-send-email-carlo@caione.org>
References: <1410466300-19168-1-git-send-email-carlo@caione.org>
 <1410466300-19168-6-git-send-email-carlo@caione.org>
Message-ID: <3053926.qBD36ymAOD@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 11 September 2014 22:11:36 Carlo Caione wrote:
> Meson6 SoCs are equipped with 5 32-bit timers, called TIMER_A, TIMER_B,
> TIMER_C, TIMER_D and TIMER_E.
> 
> The driver is providing clocksource support for the 32-bit counter using
> TIMER_E. Clockevents are also supported using TIMER_A.
> 
> Signed-off-by: Carlo Caione <carlo@caione.org>
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>

We should take all the platform code through the arm-soc tree, this one
along with the DT binding document should go through the clocksource
tree.
