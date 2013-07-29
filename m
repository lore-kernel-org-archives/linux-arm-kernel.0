From: nm@ti.com (Nishanth Menon)
Date: Mon, 29 Jul 2013 08:17:25 -0500
Subject: [PATCH 0/9] ARM: dts: omap5-uevm: fixup wrong regulator
 configuration
In-Reply-To: <51F63C74.6070503@ti.com>
References: <1374079538-19548-1-git-send-email-nm@ti.com>
 <51F63C74.6070503@ti.com>
Message-ID: <51F66B65.4030702@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/29/2013 04:57 AM, Keerthy wrote:
> Hi Nishanth,
>
> On Wednesday 17 July 2013 10:15 PM, Nishanth Menon wrote:
>> Due to wrong older revision of documentation used as reference, we
>> seem to have a bunch of LDOs wrongly configured on OMAP5 uEVM. This
>> series is based power tree on production board 750-2628-XXX platform.
>> Unfortunately, the wrong voltages may be detrimental to OMAP5 as they
>> supply hardware blocks at voltages that are out of specification.
>
> This series looks good to me.
>
> Acked-by:  J Keerthy <j-keerthy@ti.com>

Tony, Benoit - this series could prevent OMAP5 from being damaged on 
uEVMs with current 3.11 rc - could you suggest what we need to do to get 
it in?


-- 
Regards,
Nishanth Menon
