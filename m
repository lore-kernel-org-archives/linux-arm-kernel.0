From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 31 Oct 2014 14:06:30 +0100
Subject: [PATCH v2 4/4] ARM: mvebu: Enable the reference clock for timer
 and watchdog on Armada 375 SoC
In-Reply-To: <1414248522-16055-5-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1414248522-16055-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1414248522-16055-5-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20141031140630.1d6d5067@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Ezequiel Garcia,

On Sat, 25 Oct 2014 11:48:42 -0300, Ezequiel Garcia wrote:
> Now that the timer and watchdog drivers support the Armada 375 usage of
> the reference clock, we can enable it in the devicetree.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  arch/arm/boot/dts/armada-375.dtsi | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)

Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
