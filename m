From: cov@codeaurora.org (Christopher Covington)
Date: Wed, 29 May 2013 14:09:23 -0400
Subject: [PATCH v4 3/4] arm: introduce CONFIG_PARAVIRT,
 PARAVIRT_TIME_ACCOUNTING and pv_time_ops
In-Reply-To: <1369763672-12919-3-git-send-email-stefano.stabellini@eu.citrix.com>
References: <alpine.DEB.2.02.1305281835080.4799@kaball.uk.xensource.com>
 <1369763672-12919-3-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <51A64453.5040005@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefano,

On 05/28/2013 01:54 PM, Stefano Stabellini wrote:
> Introduce CONFIG_PARAVIRT and PARAVIRT_TIME_ACCOUNTING on ARM.
> 
> The only paravirt interface supported is pv_time_ops.steal_clock, so no
> runtime pvops patching needed.
> 
> This allows us to make use of steal_account_process_tick for stolen
> ticks accounting.
> 
> Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> CC: linux at arm.linux.org.uk
> CC: will.deacon at arm.com
> CC: nico at linaro.org
> CC: marc.zyngier at arm.com
> CC: cov at codeaurora.org
> CC: arnd at arndb.de
> CC: olof at lixom.net
> 
> Changes in v3:
> - improve commit description and Kconfig help text;
> - no need to initialize pv_time_ops;
> - add PARAVIRT_TIME_ACCOUNTING.

Looks good to me.

Acked-by: Christopher Covington <cov@codeaurora.org>

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by the Linux Foundation.
