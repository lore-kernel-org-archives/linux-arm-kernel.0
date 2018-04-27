From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri, 27 Apr 2018 15:47:26 +0100
Subject: [PATCH] firmware: arm_scmi: Use after free in
 scmi_create_protocol_device()
In-Reply-To: <20180427140649.GD19583@mwanda>
References: <20180427140649.GD19583@mwanda>
Message-ID: <23e2c622-8903-1207-4bce-58b3e8b51de7@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 27/04/18 15:06, Dan Carpenter wrote:
> We need to return here instead of setting up the freed sdev device as a
> transport.
> 
> Fixes: 907b6d14911d ("firmware: arm_scmi: add per-protocol channels support using idr objects")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Thanks for the fix, will send to ARM-SoC in the next round.

-- 
Regards,
Sudeep
