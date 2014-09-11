From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Thu, 11 Sep 2014 14:20:41 +0200
Subject: [PATCH v5 09/12] sched: add usage_load_avg
In-Reply-To: <20140911111736.GV3190@worktop.ger.corp.intel.com>
References: <1409051215-16788-1-git-send-email-vincent.guittot@linaro.org>
 <1409051215-16788-10-git-send-email-vincent.guittot@linaro.org>
 <20140911111736.GV3190@worktop.ger.corp.intel.com>
Message-ID: <CAKfTPtBMNLmvkfvwc3Ggv42ADLWw2GdFSDmWKWizPb+gLUULgQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 September 2014 13:17, Peter Zijlstra <peterz@infradead.org> wrote:

>>  };
>>
>
> Man, I should go look at Yuyang's rewrite of this all again. I just
> tried to figure out the decay stuff and my head hurts ;-)

Regarding Yuyang's rewrite, i had a patch above his patches to add the
running figure that i haven't sent yet
