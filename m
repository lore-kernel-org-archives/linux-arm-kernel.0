From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 15 Jun 2018 13:23:49 +0200
Subject: [PATCH 5/6] arm64: dts: rockchip: Add missing cooling device
 properties for CPUs
In-Reply-To: <d7f32cb0c3b77901cb5e37320a454e5e1dfed958.1527225682.git.viresh.kumar@linaro.org>
References: <cover.1527225682.git.viresh.kumar@linaro.org>
 <d7f32cb0c3b77901cb5e37320a454e5e1dfed958.1527225682.git.viresh.kumar@linaro.org>
Message-ID: <5093249.sUvQcHjlij@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 25. Mai 2018, 07:40:05 CEST schrieb Viresh Kumar:
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
> Do minor rearrangement as well to keep ordering consistent.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

applied for 4.19


Thanks
Heiko
