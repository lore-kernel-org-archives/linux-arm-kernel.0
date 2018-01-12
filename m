From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 12 Jan 2018 08:52:23 +0530
Subject: [PATCH 1/3] arm: spear600: Add missing interrupt-parent of rtc
In-Reply-To: <20180112020711.6gp2pnsxxjzelidq@localhost>
References: <a062d9ed0d3365b578156a780202fa533e725374.1515650104.git.viresh.kumar@linaro.org>
 <20180112020711.6gp2pnsxxjzelidq@localhost>
Message-ID: <20180112032223.GK3626@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11-01-18, 18:07, Olof Johansson wrote:
> On Thu, Jan 11, 2018 at 11:28:51AM +0530, Viresh Kumar wrote:
> > The interrupt-parent of rtc was missing, add it.
> > 
> > Fixes: 8113ba917dfa ("ARM: SPEAr: DT: Update device nodes")
> > Cc: stable at vger.kernel.org # v3.8+
> > Reported-by: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> Applied to next/dt. Is stable really needed on this? It's been broken since
> pretty much forever, and nobody has complained... :)

Not sure. Just thought it may be useful for someone somewhere :)

-- 
viresh
