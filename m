From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 1 May 2018 19:47:01 +0530
Subject: [PATCH v9 06/27] ARM: davinci: da850: add new clock init using
 common clock framework
In-Reply-To: <20180427001745.4116-7-david@lechnology.com>
References: <20180427001745.4116-1-david@lechnology.com>
 <20180427001745.4116-7-david@lechnology.com>
Message-ID: <525160f1-056b-69d1-2ce2-e5bdff8bffcc@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 27 April 2018 05:47 AM, David Lechner wrote:
> This adds the new board-specific clock init in mach-davinci/da850.c
> using the new common clock framework drivers.
> 
> The #ifdefs are needed to prevent compile errors until the entire
> ARCH_DAVINCI is converted.
> 
> Also clean up the #includes since we are adding some here.
> 
> Some CFGCHIP macros were removed because we are now including
> linux/mfd/da8xx-cfgchip.h which defines the same values.
> 
> Signed-off-by: David Lechner <david@lechnology.com>

Reviewed-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar
