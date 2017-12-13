From: gengdongjiu@huawei.com (gengdongjiu)
Date: Wed, 13 Dec 2017 10:12:18 +0800
Subject: [PATCH v2] arm64: v8.4: Support for new floating point
 multiplication instructions
In-Reply-To: <20171212145340.GN22781@e103592.cambridge.arm.com>
References: <1513089419-13295-1-git-send-email-gengdongjiu@huawei.com>
 <20171212145340.GN22781@e103592.cambridge.arm.com>
Message-ID: <0339b6e0-93d8-bb6d-8e6c-a402d39f6a9b@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 2017/12/12 22:53, Dave Martin wrote:
>> +HWCAP_FHM
> This needs to match the name of the #define in hwcap.h.
Thanks for the comments, have changed it.

> 
> With that change, Reviewed-by: Dave Martin <Dave.Martin@arm.com>
Dave, appreciate for the review


> 
> Cheers
> ---Dave
> 
> 
