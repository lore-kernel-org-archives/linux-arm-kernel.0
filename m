From: tony@atomide.com (Tony Lindgren)
Date: Tue, 25 Oct 2011 10:26:33 +0200
Subject: [PATCH] of: Add a reg-names property to name reg entries
In-Reply-To: <1319471697-8970-1-git-send-email-b-cousson@ti.com>
References: <1319471697-8970-1-git-send-email-b-cousson@ti.com>
Message-ID: <20111025082632.GJ4429@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Benoit Cousson <b-cousson@ti.com> [111024 17:20]:
> +		compatible = "ti,mcasp";
> +		reg = <0 0x10 0x10>, <0 0x20 0x10>,
> +		      <1 0x10 0x10>, <1 0x20 0x10>;
> +		reg-names = "mpu", "dat",
> +			    "dma", "dma_dat";

Hmm for some systems looks like this can also solve how to pass the
mux signal names cleanly from DT.

For some systems we may also need reg-bits in addition to reg-names
to describe the signal names. Or do we already have something for
that?

Tony
