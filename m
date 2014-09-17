From: peterz@infradead.org (Peter Zijlstra)
Date: Thu, 18 Sep 2014 01:03:25 +0200
Subject: [PATCH v5 11/12] sched: replace capacity_factor by utilization
In-Reply-To: <20140917184527.GB9854@e103034-lin>
References: <1409051215-16788-1-git-send-email-vincent.guittot@linaro.org>
 <1409051215-16788-12-git-send-email-vincent.guittot@linaro.org>
 <20140911161517.GA3190@worktop.ger.corp.intel.com>
 <CAKfTPtDFuzxzGBKi_n6v_F8FUkQ84MW+dQBX4WNXo-o54mksGA@mail.gmail.com>
 <20140914194156.GC2832@worktop.localdomain>
 <20140915114229.GB3037@worktop.localdomain>
 <alpine.LFD.2.11.1409151451540.8647@knanqh.ubzr>
 <20140915200159.GE2840@worktop.localdomain>
 <20140917184527.GB9854@e103034-lin>
Message-ID: <20140917230325.GI2848@worktop.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 17, 2014 at 07:45:27PM +0100, Morten Rasmussen wrote:
> Right. You don't need to scale capacity to determine whether a cpu is
> full or not if you don't have DVFS, but I don't think it hurts if it is
> done right. We need the scaling to figure out how much capacity is
> available.

Maybe I'm particularly dense, but I'm not seeing how the proposed thing
is 'right' in any way.

There are no words on what specifically is addressed and how it is
achieved.
