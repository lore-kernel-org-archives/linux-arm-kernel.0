From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sat, 24 Dec 2011 12:24:11 +0000
Subject: [PATCH v4 4/7] cpufreq: add clk-reg cpufreq driver
In-Reply-To: <20111224085539.GA1892@richard-laptop>
References: <1324537753-30590-1-git-send-email-richard.zhao@linaro.org>
 <1324537753-30590-5-git-send-email-richard.zhao@linaro.org>
 <20111223131851.GB13175@sirena.org.uk>
 <20111224085539.GA1892@richard-laptop>
Message-ID: <20111224122411.GA13778@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 24, 2011 at 04:55:42PM +0800, Richard Zhao wrote:
> On Fri, Dec 23, 2011 at 01:18:51PM +0000, Mark Brown wrote:

> > > +- trans-latency :  transition_latency, in unit of ns.

> > trans-latency should really say what latency is being measured (the CPU
> > core only or the whole operation).

> dts only descibe hw info. so the transition latency is for hw.
> - trans-latency :  transition latency of HW, in unit of ns.

The issue is that you need to clarify which hardware this is - it's the
clocks only, not the time for regulators.
