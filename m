From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 4 Sep 2014 22:10:15 +0200
Subject: [PATCH] ARM: configs: Enable cpufreq-cpu0 for multi_v7_defconfig
In-Reply-To: <CAKohpo=amz9+7Q2bF_hqKKw+RixLngi-xwR8GU9L1pi6kvYnqA@mail.gmail.com>
References: <1409486979-26869-1-git-send-email-broonie@kernel.org>
 <CAKohpo=amz9+7Q2bF_hqKKw+RixLngi-xwR8GU9L1pi6kvYnqA@mail.gmail.com>
Message-ID: <201409042210.15473.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 01 September 2014, Viresh Kumar wrote:
> On 31 August 2014 17:39, Mark Brown <broonie@kernel.org> wrote:
> > Many boards share the cpufreq-cpu0 driver meaning that if we enable it in
> > multi_v7_defconfig we can get a reasonable amount of functional utility for
> > systems and test coverage for a fairly small increase in kernel size.
> >
> > Signed-off-by: Mark Brown <broonie@kernel.org>
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied to next/defconfig, thanks!

	Arnd
