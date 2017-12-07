From: robh@kernel.org (Rob Herring)
Date: Thu, 7 Dec 2017 17:46:42 -0600
Subject: [PATCH v2 1/3] regulator: axp20x: add drivevbus support for axp803
In-Reply-To: <1512673460-7865-1-git-send-email-jagan@amarulasolutions.com>
References: <1512673460-7865-1-git-send-email-jagan@amarulasolutions.com>
Message-ID: <20171207234642.ucqmtxpufvhu4cgr@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 08, 2017 at 12:34:18AM +0530, Jagan Teki wrote:
> Like axp221, axp223, axp813 the axp803 is also supporting external
> regulator to drive the  OTG VBus through N_VBUSEN PMIC pin.
> 
> Add support for it.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v2:
> - New patch
> 
>  Documentation/devicetree/bindings/mfd/axp20x.txt | 2 +-
>  drivers/regulator/axp20x-regulator.c             | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>
