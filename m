From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 27 Mar 2013 17:48:17 +0000 (UTC)
Subject: omap cpufreq driver in multi-platform kernels
In-Reply-To: <20130327133220.GA30868@kahuna>
References: <5152503C.2050503@gmail.com>
 <alpine.DEB.2.00.1303270212110.8161@utopia.booyaka.com>
 <20130327133220.GA30868@kahuna>
Message-ID: <alpine.DEB.2.00.1303271747210.17356@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On Wed, 27 Mar 2013, Nishanth Menon wrote:

> We should deprecate usage on omap-cpufreq driver eventually, instead go
> towards embracing the SoC generic implementation of cpufreq-cpu0 driver
> IMHO.
> http://marc.info/?l=linux-omap&m=136371580826031&w=2
> is the series to support cpufreq_cpu0 driver in DT based boot.
> Would you think this approach is sane? 

Haven't looked closely at the series, but the idea makes sense to me, as 
long as OMAP doesn't need to do anything too exotic in the CPUFreq driver.



- Paul
