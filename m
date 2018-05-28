From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 28 May 2018 16:27:34 +0530
Subject: [PATCH 06/15] arm: dts: sun: Add missing cooling device
 properties for CPUs
In-Reply-To: <20180528084446.g24fphqqac2hi3rr@flea>
References: <cover.1527244200.git.viresh.kumar@linaro.org>
 <eded393f4b508a1f377f9af6859a3b82a6787e1c.1527244201.git.viresh.kumar@linaro.org>
 <20180528084446.g24fphqqac2hi3rr@flea>
Message-ID: <20180528105734.bkplm7tfaqsurdrn@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28-05-18, 10:44, Maxime Ripard wrote:
> Hi,
> 
> On Fri, May 25, 2018 at 04:01:52PM +0530, Viresh Kumar wrote:
> > The cooling device properties, like "#cooling-cells" and
> > "dynamic-power-coefficient", should either be present for all the CPUs
> > of a cluster or none. If these are present only for a subset of CPUs of
> > a cluster then things will start falling apart as soon as the CPUs are
> > brought online in a different order. For example, this will happen
> > because the operating system looks for such properties in the CPU node
> > it is trying to bring up, so that it can register a cooling device.
> > 
> > Add such missing properties.
> > 
> > Fix other missing properties (clocks, OPP, clock latency) as well to
> > make it all work.
> > 
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> The prefix should be sunxi and not sun, but it looks good to me
> otherwise.
> 
> Let me know what your preferred merge method is.

Please pick it up directly and send it as part of your pull request.
Do you want me to resend or can you fix the $subject ?

Thanks.

-- 
viresh
