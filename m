From: peda@axentia.se (Peter Rosin)
Date: Tue, 30 May 2017 15:11:25 +0200
Subject: [PATCH v2 3/4] ARM: dts: at91: Switch to the new NAND bindings
In-Reply-To: <1496136054-12390-4-git-send-email-boris.brezillon@free-electrons.com>
References: <1496136054-12390-1-git-send-email-boris.brezillon@free-electrons.com>
 <1496136054-12390-4-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <4561101c-3032-3cdf-7588-31372510c5b3@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017-05-30 11:20, Boris Brezillon wrote:
> Use the new EBI/NAND bindings to declare NAND chips and remove old NAND
> nodes along the way.
> 
> Note that we keep using old bindings in at91rm9200.dtsi because this
> SoC is not supported by the EBI driver.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Cc: Jiri Prchal <jiri.prchal@aksignal.cz>
> Cc: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Cc: Rodolfo Giometti <giometti@linux.it>
> Cc: Antoine Aubert <a.aubert@overkiz.com>
> Cc: Peter Rosin <peda@axentia.se>
> Cc: info at egnite.de
> Cc: Fabio Porcedda <fabio.porcedda@gmail.com>
> ---

For at91-tse850-3.dts (and therefore at91-linea.dtsi).

Tested-by: Peter Rosin <peda@axentia.se>

Cheers,
peda
