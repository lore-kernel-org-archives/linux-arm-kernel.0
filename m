From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 25 Sep 2013 14:21:50 +0100
Subject: [PATCH] arm64: avoid multiple evaluation of ptr in
 get_user/put_user()
In-Reply-To: <5242AD10.3070001@linaro.org>
References: <524154C2.1080303@linaro.org> <20130924142553.GG25907@arm.com>
 <5242AD10.3070001@linaro.org>
Message-ID: <20130925132149.GA27093@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 25, 2013 at 10:29:52AM +0100, AKASHI Takahiro wrote:
> Thank you for your comments, and let me send a revised patch again
> because my original message didn't reach MLs due to my screw-up.

You can send it if you want but I already merged it in my tree (should
appear in -next this week as well).

-- 
Catalin
