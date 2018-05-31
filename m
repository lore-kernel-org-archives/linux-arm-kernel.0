From: robh@kernel.org (Rob Herring)
Date: Wed, 30 May 2018 22:53:42 -0500
Subject: [PATCH v2 5/9] PM / Domains: dt: Allow power-domain property to
 be a list of specifiers
In-Reply-To: <20180529100421.31022-6-ulf.hansson@linaro.org>
References: <20180529100421.31022-1-ulf.hansson@linaro.org>
 <20180529100421.31022-6-ulf.hansson@linaro.org>
Message-ID: <20180531035342.GA14184@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 29, 2018 at 12:04:17PM +0200, Ulf Hansson wrote:
> To be able to describe topologies where devices are partitioned across
> multiple power domains, let's extend the power-domain property to allow
> being a list of PM domain specifiers.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree at vger.kernel.org
> Suggested-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
> 
> Changes in v2:
> 	- Fixed comments from Geert. Re-worded to "PM domain specifiers" and
> 	clarified DT example.
> 
> ---
>  .../bindings/power/power_domain.txt           | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
