From: nm@ti.com (Nishanth Menon)
Date: Tue, 16 Jun 2015 08:34:02 -0500
Subject: [PATCH V7 1/3] OPP: Add new bindings to address shortcomings
 of existing bindings
In-Reply-To: <d83c0b6b1768c7229384216329b607d13886aa02.1433434659.git.viresh.kumar@linaro.org>
References: <cover.1433434659.git.viresh.kumar@linaro.org>
 <d83c0b6b1768c7229384216329b607d13886aa02.1433434659.git.viresh.kumar@linaro.org>
Message-ID: <558025CA.8050008@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/04/2015 11:20 AM, Viresh Kumar wrote:
> Current OPP (Operating performance point) device tree bindings have been
> insufficient due to the inflexible nature of the original bindings. Over
> time, we have realized that Operating Performance Point definitions and
> usage is varied depending on the SoC and a "single size (just frequency,
> voltage) fits all" model which the original bindings attempted and
> failed.
> 
> The proposed next generation of the bindings addresses by providing a
> expandable binding for OPPs and introduces the following common
> shortcomings seen with the original bindings:
> 
> - Getting clock/voltage/current rails sharing information between CPUs.
>   Shared by all cores vs independent clock per core vs shared clock per
>   cluster.
> 
> - Support for specifying current levels along with voltages.
> 
> - Support for multiple regulators.
> 
> - Support for turbo modes.
> 
> - Other per OPP settings: transition latencies, disabled status, etc.?
> 
> - Expandability of OPPs in future.
> 
> This patch introduces new bindings "operating-points-v2" to get these problems
> solved. Refer to the bindings for more details.
> 
> We now have multiple versions of OPP binding and only one of them should
> be used per device.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

I thought I had acked the patch 1 of the series as well in the list,
but looks like I have'nt.. So, for the record..

Acked-by: Nishanth Menon <nm@ti.com>


Thanks for doing this.

-- 
Regards,
Nishanth Menon
