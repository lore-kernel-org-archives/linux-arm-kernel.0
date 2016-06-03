From: dinguyen@opensource.altera.com (Dinh Nguyen)
Date: Fri, 3 Jun 2016 11:06:55 -0500
Subject: [PATCH 5/5] ARM: dts: Move Arria10 SDRAM as child of ECC Manager
In-Reply-To: <1464193783-5071-6-git-send-email-tthayer@opensource.altera.com>
References: <1464193783-5071-1-git-send-email-tthayer@opensource.altera.com>
 <1464193783-5071-6-git-send-email-tthayer@opensource.altera.com>
Message-ID: <alpine.DEB.2.02.1606031106340.1763@linux-builds1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 25 May 2016, tthayer at opensource.altera.com wrote:

> From: Thor Thayer <tthayer@opensource.altera.com>
> 
> Changes to support ECC Manager as SDRAM IRQ parent by
> 1) updating IRQ property values to correct child IRQs
> 2) moving node under ECC Manager.
> 
> Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
> ---
>  arch/arm/boot/dts/socfpga_arria10.dtsi |   13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>

Applied! 

Thanks,
Dinh
