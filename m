From: vaibhav.bedia@ti.com (Bedia, Vaibhav)
Date: Wed, 26 Dec 2012 06:06:46 +0000
Subject: [PATCH 02/12] ARM: OMAP2+: PM: introduce power domains
 functional states
In-Reply-To: <20121209175253.6933.87846.stgit@dusk.lan>
References: <20121209174545.6933.59371.stgit@dusk.lan>
 <20121209175253.6933.87846.stgit@dusk.lan>
Message-ID: <B5906170F1614E41A8A28DE3B8D121433ECA6C83@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

A minor comment below.

On Sun, Dec 09, 2012 at 23:23:01, Paul Walmsley wrote:
[...]
> +
> +	pr_debug("powerdomain: convert pwrst (%0x,%0x) to fpwrst %0x\n",
> +		 pwrst, logic, *fpwrst);
> +

This function alone does not print the powerdomain name. Can you add that
in the final version?

Regards,
Vaibhav 
