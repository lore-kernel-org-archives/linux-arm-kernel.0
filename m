From: robh@kernel.org (Rob Herring)
Date: Wed, 1 Feb 2017 07:26:22 -0600
Subject: [PATCH 1/5] DT: mfd: axp20x: Add AXP806 to list of current
 AXP20x family members
In-Reply-To: <abdfbac9a5f363ab6d338dd66d8fb138741f71c7.1485456005.git.rask@formelder.dk>
References: <cover.1485456003.git.rask@formelder.dk>
 <abdfbac9a5f363ab6d338dd66d8fb138741f71c7.1485456005.git.rask@formelder.dk>
Message-ID: <20170201132622.ahun2xei6imt2kzc@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 26, 2017 at 10:15:14PM +0100, Rask Ingemann Lambertsen wrote:
> An entry for the AXP806 was forgotten, so add one.
> 
> Signed-off-by: Rask Ingemann Lambertsen <rask@formelder.dk>
> Fixes: 204ae2963e10 ("mfd: axp20x: Add bindings for AXP806 PMIC")
> ---
>  Documentation/devicetree/bindings/mfd/axp20x.txt | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Rob Herring <robh@kernel.org>
