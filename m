From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 8 Jul 2013 17:29:34 -0300
Subject: Handling ARM_ERRATA_364296 when CONFIG_SMP=y
In-Reply-To: <20130708182212.GF3621@1wt.eu>
References: <CAOMZO5AVpQ6DUja=usBCDzRH0NyNqbXsHNNOJSAY=8OvgHHTmA@mail.gmail.com>
 <20130708182212.GF3621@1wt.eu>
Message-ID: <CAOMZO5AeqO_AmLp1=BwrMxOd4sh-omN6vG-R5f4EgpmzqCfhrg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Willy,

On Mon, Jul 8, 2013 at 3:22 PM, Willy Tarreau <w@1wt.eu> wrote:

> Or maybe fix the config so that it does not force SMP on a CPU which
> only exists as a single core ?

The original config is imx_v6_v7_defconfig and it selects by default
both mx6 (quad core) and other single core CPUs.

That's the reason why CONFIG_SMP=y for this config by default.

Regards,

Fabio Estevam
