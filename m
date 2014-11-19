From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 19 Nov 2014 13:16:38 +0100
Subject: [PATCHv4 03/10] arm: mvebu: use recently introduced uart label
 for stdout-path
In-Reply-To: <206fa4769a1e02f3e6b139160cd5dd9d25c90837.1416351426.git.arno@natisbad.org>
References: <cover.1416351425.git.arno@natisbad.org>
 <206fa4769a1e02f3e6b139160cd5dd9d25c90837.1416351426.git.arno@natisbad.org>
Message-ID: <20141119131638.5e9735a9@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Arnaud Ebalard,

On Wed, 19 Nov 2014 00:01:59 +0100, Arnaud Ebalard wrote:
> 
> Now that labels for uartX are available in Marvell Armada .dtsi files,
> this patch replaces the "/soc/internal-regs/serial at 12000" found in
> armada-xp-lenovo-ix4-300d.dts file for stdout-path property by the more
> concise &uart0.
> 
> Suggested-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
> ---
>  arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
