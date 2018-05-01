From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 1 May 2018 15:40:46 +0100
Subject: [PATCH v8 10/13] arm64: topology: rename cluster_id
In-Reply-To: <20180425233121.13270-11-jeremy.linton@arm.com>
References: <20180425233121.13270-1-jeremy.linton@arm.com>
 <20180425233121.13270-11-jeremy.linton@arm.com>
Message-ID: <06cdff18-8544-8748-4164-9adb20cfb304@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 26/04/18 00:31, Jeremy Linton wrote:
> Lets match the name of the arm64 topology field
> to the kernel macro that uses it.

[nit] You can add a note that cluster id is not architectural defined
for ARM platforms just to elaborate on the intention for this change.

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
