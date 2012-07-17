From: rnayak@ti.com (Rajendra Nayak)
Date: Tue, 17 Jul 2012 19:24:35 +0530
Subject: [PATCH] clk: fix compile for OF && !COMMON_CLK
In-Reply-To: <50056CB3.90004@gmail.com>
References: <1342475161-20402-1-git-send-email-robherring2@gmail.com>
 <20120717001228.GA28886@gmail.com> <5004C935.4050707@gmail.com>
 <50056648.6000906@ti.com> <50056CB3.90004@gmail.com>
Message-ID: <50056E9B.1060509@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 17 July 2012 07:16 PM, Rob Herring wrote:
>> So how is this expected to work on platforms (like OMAP) which have
>> >  CONFIG_OF enabled but not CONFIG_COMMON_CLK?
>> >
> As I mentioned in my other reply, this really belongs with Shawn's patch
> that changes the return value checking from NULL to err values.
>
ah, I seemed to have missed that. Just had a look at Shawn's patch and
that should work for OMAP too. thanks.
