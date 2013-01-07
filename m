From: gang.chen@asianux.com (Chen Gang)
Date: Mon, 07 Jan 2013 20:02:28 +0800
Subject: [PATCH] arch/arm/mach-s5pv210: adding ifdef CONFIG_CPU_S5PV210
 to fix compiling issue
In-Reply-To: <50EA972E.3040404@asianux.com>
References: <50EA972E.3040404@asianux.com>
Message-ID: <50EAB954.4090504@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2013?01?07? 17:36, Chen Gang ??:
> 
>  
> +#ifdef CONFIG_CPU_S5PV210
> +
>  struct bus_type s5pv210_subsys = {
>  	.name		= "s5pv210-core",
>  	.dev_name	= "s5pv210-core",

  sorry, it is my fault.
    should let s5pv210_subsys outside of #ifdef CONFIG_CPU_S5PV210.
    it is used in pm.c

  I need send patch v2.


-- 
Chen Gang

Asianux Corporation
