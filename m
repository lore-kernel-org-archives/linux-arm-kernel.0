From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 19 Nov 2014 13:16:01 +0100
Subject: [PATCHv4 02/10] arm: mvebu: add uartX labels for Armada SoC
 serial nodes
In-Reply-To: <8c622c408d74d5e9fc36b7c00f9e8aeb3f290683.1416351426.git.arno@natisbad.org>
References: <cover.1416351425.git.arno@natisbad.org>
 <8c622c408d74d5e9fc36b7c00f9e8aeb3f290683.1416351426.git.arno@natisbad.org>
Message-ID: <20141119131601.606bdad8@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Arnaud Ebalard,

On Wed, 19 Nov 2014 00:01:47 +0100, Arnaud Ebalard wrote:
> 
> This patch adds uartX labels for Armada SoC serial nodes. This is
> a preliminary work to be able to easily reference the serial lines
> in Device Tree files. One expected use is when providing stdout-path
> property for barebox.
> 
> Acked-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
> ---
>  arch/arm/boot/dts/armada-370-xp.dtsi | 5 +++--
>  arch/arm/boot/dts/armada-xp.dtsi     | 5 +++--
>  2 files changed, 6 insertions(+), 4 deletions(-)

Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
