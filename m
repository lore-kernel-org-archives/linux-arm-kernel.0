From: heiko@sntech.de (Heiko Stuebner)
Date: Sun, 17 Jun 2018 16:47:07 +0200
Subject: [PATCH 04/15] arm: dts: rk322x: Add missing cooling device
 properties for CPUs
In-Reply-To: <406021e33d541ca0318a6b15687084ca19fdd943.1527244201.git.viresh.kumar@linaro.org>
References: <cover.1527244200.git.viresh.kumar@linaro.org>
 <406021e33d541ca0318a6b15687084ca19fdd943.1527244201.git.viresh.kumar@linaro.org>
Message-ID: <6654764.Ls0NFkadpc@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 25. Mai 2018, 12:31:50 CEST schrieb Viresh Kumar:
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
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

applied for 4.19

Thanks
Heiko
