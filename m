From: balbi@ti.com (Felipe Balbi)
Date: Tue, 12 May 2015 11:19:45 -0500
Subject: [PATCH V4 1/3] OPP: Redefine bindings to overcome shortcomings
In-Reply-To: <d225e73f183e01fa0b71e4b9248b6a19a3f7d697.1430394884.git.viresh.kumar@linaro.org>
References: <cover.1430394884.git.viresh.kumar@linaro.org>
 <d225e73f183e01fa0b71e4b9248b6a19a3f7d697.1430394884.git.viresh.kumar@linaro.org>
Message-ID: <20150512161945.GE8699@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 30, 2015 at 05:37:59PM +0530, Viresh Kumar wrote:
> Current OPP (Operating performance point) DT bindings are proven to be
> insufficient at multiple instances.
> 
> The shortcomings we are trying to solve here:
> 
> - Getting clock sharing information between CPUs. Single shared clock vs
>   independent clock per core vs shared clock per cluster.
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

operating-points-v2 is kinda awkward, how about
operating-points-extended, much like interrupts-extended ?

Other than this, I very much like the new approach.

Regards

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150512/cfdb15c5/attachment.sig>
