From: heiko@sntech.de (Heiko Stuebner)
Date: Sun, 17 Jun 2018 16:47:57 +0200
Subject: [PATCH 10/15] arm: dts: rk3288: Add missing cooling device
 properties for CPUs
In-Reply-To: <11f16618dc965a7996976a2bca040cd87d1961d2.1527244201.git.viresh.kumar@linaro.org>
References: <cover.1527244200.git.viresh.kumar@linaro.org>
 <11f16618dc965a7996976a2bca040cd87d1961d2.1527244201.git.viresh.kumar@linaro.org>
Message-ID: <2717295.dpLKm0oEe9@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 25. Mai 2018, 12:31:56 CEST schrieb Viresh Kumar:
> The cooling device properties, like "#cooling-cells" and
> "dynamic-power-coefficient", should either be present for all the CPUs
> of a cluster or none. If these are present only for a subset of CPUs of
> a cluster then things will start falling apart as soon as the CPUs are
> brought online in a different order. For example, this will happen
> because the operating system looks for such properties in the CPU node
> it is trying to bring up, so that it can register a cooling device.
> 
> Add such missing properties.
> 
> Fix other missing properties (clocks, OPP, clock latency) as well to
> make it all work.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

applied for 4.19, after adapting the patch to the opp-v2 conversion
I Cc'ed you on [for your reference].


Thanks
Heiko
