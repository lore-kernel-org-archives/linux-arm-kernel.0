From: tony@atomide.com (Tony Lindgren)
Date: Wed, 24 Oct 2012 16:27:17 -0700
Subject: [PATCH 4/4] OMAP: mtd: gpmc: add DT bindings for GPMC timings
 and NAND
In-Reply-To: <1350935758-9215-5-git-send-email-zonque@gmail.com>
References: <1350935758-9215-1-git-send-email-zonque@gmail.com>
 <1350935758-9215-5-git-send-email-zonque@gmail.com>
Message-ID: <20121024232717.GD11928@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Daniel Mack <zonque@gmail.com> [121022 12:57]:
> This patch adds basic DT bindings for OMAP GPMC.
> 
> The actual peripherals are instanciated from child nodes within the GPMC
> node, and the only type of device that is currently supported is NAND.
> 
> Code was added to parse the generic GPMC timing parameters and some
> documentation with examples on how to use them.
> 
> Successfully tested on an AM33xx board.

That's great, looks good to me. Please repost at least the
binding patch with devicetree-discuss and Rob Herring cc:d
so hopefully we'll get an ack for the binding.

Regards,

Tony
