From: tony@atomide.com (Tony Lindgren)
Date: Wed, 6 Jun 2018 03:09:37 -0700
Subject: [PATCH v3 0/6] Add MCAN Support for dra76x
In-Reply-To: <20180606060826.14671-1-faiz_abbas@ti.com>
References: <20180606060826.14671-1-faiz_abbas@ti.com>
Message-ID: <20180606100937.GF5738@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Faiz Abbas <faiz_abbas@ti.com> [180606 06:09]:
> The following patches add dts and sysconfig support
> for MCAN on TI's dra76 SOCs
> 
> The patches depend on the following series:
> https://patchwork.kernel.org/patch/10221105/
> 
> Changes in v3:
>  1. Added reset functionality to the ti-sysc
>     driver. This enables me to drop the hwmod
>     data patch as everything is being done in dt.
>
>  2. Dropped ti,hwmods from the dts nodes

Cool good to hear that works :)

>  4. Removed the status="disabled" in dtsi
>     followed by status="okay" in dts.

Hmm okay is the default and is not needed. I did not notice
okay in this set based on a quick glance so maybe you already
dropped it?

Regards,

Tony
