From: tony@atomide.com (Tony Lindgren)
Date: Mon, 7 Dec 2015 16:19:43 -0800
Subject: [PATCH] ARM: DTS: am33xx: Use the new DT bindings for the eDMA3
In-Reply-To: <1449225915-28879-1-git-send-email-peter.ujfalusi@ti.com>
References: <1449225915-28879-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20151208001943.GT23396@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [151204 02:46]:
> +
> +			ti,tptcs = <&edma_tptc0 7>, <&edma_tptc1 5>,
> +				   <&edma_tptc2 0>;
> +
> +			ti,edma-memcpy-channels = /bits/ 16 <20 21>;

Is this safe to change to just ti,edma-memcpy-channels = <20 21> as
suggested by Arnd?

Regards,

Tony
