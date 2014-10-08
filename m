From: pure.logic@nexus-software.ie (Bryan O'Donoghue)
Date: Wed, 08 Oct 2014 02:03:18 +0100
Subject: [PATCH 2/2 v2] SPI: spi-pxa2xx: SPI support for Intel Quark X1000
In-Reply-To: <1412000548-9908-3-git-send-email-alvin.chen@intel.com>
References: <1412000548-9908-1-git-send-email-alvin.chen@intel.com>
 <1412000548-9908-3-git-send-email-alvin.chen@intel.com>
Message-ID: <54348D56.20708@nexus-software.ie>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/09/14 15:22, Weike Chen wrote:
> +		.num_chipselect = 4,

How is this right ?

There's only one physical chip-select line per SPI master...

It's a 1:1 mapping.

Best,
Bryan
