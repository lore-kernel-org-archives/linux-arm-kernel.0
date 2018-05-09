From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 9 May 2018 17:34:30 +0100
Subject: [PATCH] arm64: dts: juno: fix OF graph endpoint node names
In-Reply-To: <20180508150952.24562-1-robh@kernel.org>
References: <20180508150952.24562-1-robh@kernel.org>
Message-ID: <e4775e42-fb07-c51c-2698-0bfe6e7b9417@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 08/05/18 16:09, Rob Herring wrote:
> OF graph endpoint node names should be 'endpoint'. Fix the following
> warnings found by dtc:
> 
> Warning (graph_endpoint): /hdlcd at 7ff50000/port/hdlcd1-endpoint: graph endpont node nameshould be 'endpoint'
> Warning (graph_endpoint): /hdlcd at 7ff60000/port/hdlcd0-endpoint: graph endpont node nameshould be 'endpoint'
> Warning (graph_endpoint): /i2c at 7ffa0000/hdmi-transmitter at 70/port/tda998x-0-endpoint: graph endpont node name should be 'endpoint'
> Warning (graph_endpoint): /i2c at 7ffa0000/hdmi-transmitter at 71/port/tda998x-1-endpoint: graph endpont node name should be 'endpoint'
> 
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Signed-off-by: Rob Herring <robh@kernel.org>

Thanks Robs, both patches applied.

-- 
Regards,
Sudeep
