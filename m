From: santosh.shilimkar@oracle.com (santosh.shilimkar at oracle.com)
Date: Mon, 17 Jul 2017 21:47:33 -0700
Subject: [PATCH 0/4] Add various TI-SCI DT nodes on 66AK2G SoCs
In-Reply-To: <20170718032844.29490-1-s-anna@ti.com>
References: <20170718032844.29490-1-s-anna@ti.com>
Message-ID: <33691a29-4a50-36e0-ad87-b5698d26bf77@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/17/17 8:28 PM, Suman Anna wrote:
> Hi Santosh,
> 
> The following patch series adds various TI-SCI related DTS nodes that
> probe the corresponding TI-SCI genpd, clock and reset drivers for the
> 66AK2G platforms.
> 
> This is the second of two series, and these nodes along with the defconfig
> patches finally allows adding other peripherals to the 66AK2G platforms.
> All the new peripherals should/will be added without using the device id
> macros [1]. Patches are baselined on 4.13-rc1 and are intended for the 4.14
> merge window.
> 
And this one looks good as well. Please ping me if you don't see this 
show up in next, by next week.

Regards,
Santosh
