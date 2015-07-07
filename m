From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 07 Jul 2015 10:11:24 +0200
Subject: [PULL] clockevents: last minute patch for 4.2-rc2
In-Reply-To: <alpine.DEB.2.11.1507061925080.3916@nanos>
References: <cover.1436178990.git.viresh.kumar@linaro.org>
 <alpine.DEB.2.11.1507061925080.3916@nanos>
Message-ID: <559B89AC.7090802@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Thomas,

as requested, this pull request contains a single patch from Viresh to 
make the different set-state callbacks optional.

  - Made set-state callbacks optional (Viresh Kumar)


Thanks !

   -- Daniel


The following changes since commit 1cb6c2151850584ee805fdcf088af0bb81f4b086:

   clocksource: Increase dependencies of timer-stm32 to limit build 
wreckage (2015-06-21 20:01:48 +0200)

are available in the git repository at:

   http://git.linaro.org/people/daniel.lezcano/linux.git clockevents/4.2-rc2

for you to fetch changes up to 367c508a7c91b9e68f4d0c39b4631a8f74f7e016:

   clockevents: Allow set-state callbacks to be optional (2015-07-07 
10:04:29 +0200)

----------------------------------------------------------------
Viresh Kumar (1):
       clockevents: Allow set-state callbacks to be optional

  kernel/time/clockevents.c | 24 +++++++++---------------
  1 file changed, 9 insertions(+), 15 deletions(-)

-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
