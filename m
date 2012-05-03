From: afzal@ti.com (Mohammed, Afzal)
Date: Thu, 3 May 2012 08:54:08 +0000
Subject: [PATCH v4 06/39] ARM: OMAP2+: onenand: return value in init
 function
In-Reply-To: <4FA01421.9080808@mvista.com>
References: <cover.1335874494.git.afzal@ti.com>
 <91c09cb6a6cb5e87acdcc3f6100a87b4c2a3dd41.1335874494.git.afzal@ti.com>
 <4FA01421.9080808@mvista.com>
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E982A0E@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On Tue, May 01, 2012 at 22:19:37, Sergei Shtylyov wrote:
> > +
> > +#if defined(CONFIG_MTD_ONENAND_OMAP2) || \
> > +		defined(CONFIG_MTD_ONENAND_OMAP2_MODULE)
> 
>     You can use IS_ENABLED(CONFIG_MTD_ONENAND_OMAP2) instead these two.

Thanks for educating me.

Regards
Afzal
