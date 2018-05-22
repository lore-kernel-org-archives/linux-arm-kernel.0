From: robh@kernel.org (Rob Herring)
Date: Tue, 22 May 2018 17:30:24 -0500
Subject: [PATCH 1/2] soc: bcm: brcmstb: pm: Add support for newer rev
 B3.0 controllers
In-Reply-To: <20180511220242.837-2-f.fainelli@gmail.com>
References: <20180511220242.837-1-f.fainelli@gmail.com>
 <20180511220242.837-2-f.fainelli@gmail.com>
Message-ID: <20180522223024.GA7817@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 11, 2018 at 03:02:41PM -0700, Florian Fainelli wrote:
> From: Doug Berger <opendmb@gmail.com>
> 
> Update the Device Tree binding document and add a matching entry for the
> MEMC DDR controller revision B3.0 which is found on chips like 7278A0
> and newer.
> 
> Signed-off-by: Doug Berger <opendmb@gmail.com>
> [florian: tweak commit message, make it apply to upstream kernel]
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/bcm/brcm,brcmstb.txt | 1 +
>  drivers/soc/bcm/brcmstb/pm/pm-arm.c                        | 4 ++++
>  2 files changed, 5 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>

Side note: this should really move out of bindings/arm/ to 
bindings/memory-controllers/ or at least to its own file.

Rob
