From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 9 Oct 2017 10:25:56 +0100
Subject: [PATCH] firmware: arm_scpi: silence sparse warnings
In-Reply-To: <05d15d9d-4664-8bbe-ea4b-90e538d2c1b3@gmail.com>
References: <05d15d9d-4664-8bbe-ea4b-90e538d2c1b3@gmail.com>
Message-ID: <f134eee1-6106-e459-57c3-7530a7e6072f@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 06/10/17 19:59, Heiner Kallweit wrote:
> At several positions in the code sparse complains about incorrect access
> to __iomem annotated memory. Fix this and make sparse happy.
> 
I just cooked exact same patch ready in my local tree last Friday :).
I will apply this. Thanks.

-- 
Regards,
Sudeep
