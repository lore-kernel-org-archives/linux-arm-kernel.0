From: tony@atomide.com (Tony Lindgren)
Date: Tue, 27 Dec 2016 09:52:30 -0800
Subject: [PATCH 0/4] dt-bindings: mfd: Update TPS65217 interrupts
In-Reply-To: <20161209062833.5768-1-woogyom.kim@gmail.com>
References: <20161209062833.5768-1-woogyom.kim@gmail.com>
Message-ID: <20161227175229.GU4920@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Milo Kim <woogyom.kim@gmail.com> [161208 22:29]:
> This patch-set fixes wrong property name and uses TPS65217 HW interrupt 
> number from the datasheet instead of the DT ABI. DT bindings are also 
> updated.

Applying into omap-for-v4.10/fixes before this usage pops up on other
am335x boards.

Regards,

Tony
