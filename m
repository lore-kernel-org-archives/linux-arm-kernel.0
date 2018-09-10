From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 10 Sep 2018 17:39:29 +0100
Subject: [PATCH v3] firmware: arm_scmi: add a getter for power of
 performance states
In-Reply-To: <20180910162810.7307-1-quentin.perret@arm.com>
References: <20180910161530.izm4l22clxqktetn@queper01-lin>
 <20180910162810.7307-1-quentin.perret@arm.com>
Message-ID: <757e8159-1140-333a-256a-43290bb23a4e@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/09/18 17:28, Quentin Perret wrote:
> The SCMI protocol can be used to get power estimates from firmware
> corresponding to each performance state of a device. Although these power
> costs are already managed by the SCMI firmware driver, they are not
> exposed to any external subsystem yet.
> 
> Fix this by adding a new get_power() interface to the exisiting perf_ops
> defined for the SCMI protocol.
> 

Thanks, applied.

-- 
Regards,
Sudeep
