From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 25 Apr 2016 15:44:38 +0200
Subject: [PATCH v5 0/5] clk: mvebu: clock drivers for Marvell Armada 7K/8K
In-Reply-To: <1460648013-31320-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1460648013-31320-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20160425154438.07cca521@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen, Michael,

On Thu, 14 Apr 2016 17:33:28 +0200, Thomas Petazzoni wrote:

>   clk: mvebu: new driver for Armada AP806 system controller
>   dt-bindings: arm: add DT binding for Marvell CP110 system controller
>   clk: mvebu: new driver for Armada CP110 system controller

Do you have any comments on those three patches? Rob Herring gave his
Acked-by on the DT binding for both drivers and as you can imagine,
those drivers are essential to making this new platform work in
mainline.

Do not hesitate to let me know if anything still needs some
adaptations/changes in the clock drivers.

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
