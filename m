From: jae.hyun.yoo@linux.intel.com (Jae Hyun Yoo)
Date: Fri, 13 Jul 2018 13:37:17 -0700
Subject: [PATCH] i2c: aspeed: Adjust spinlock scope in the irq handler
In-Reply-To: <20180713203327.47yq4gucidbzn2hd@katana>
References: <20180702214011.16071-1-jae.hyun.yoo@linux.intel.com>
 <CAFd5g47nBCbF0mcYqEnQkDpz0Dhh0F0S1-wEL_yBHgs1b3yE5w@mail.gmail.com>
 <59538d26-f025-28da-63df-f675e80fd68b@linux.intel.com>
 <20180713203327.47yq4gucidbzn2hd@katana>
Message-ID: <0840cfe8-e18a-ae7c-5593-fc43b9b47291@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/13/2018 1:33 PM, Wolfram Sang wrote:
> 
>> BTW, to whom should I ask applying this patch? Should I send v2 after
>> adding your reviewed-by tag?
> 
> Not needed, thanks. I use 'patchwork' and this tool collects all the
> tags for me. If I see a patch reviewed by a driver maintainer, I'll pick
> it up in the next queue.
> 

Oh, I see. Thanks a lot Wolfram!
