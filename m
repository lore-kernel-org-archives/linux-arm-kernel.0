From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 20 Sep 2013 22:21:05 +0530
Subject: [PATCH 1/3] PM / OPP: rename functions to dev_pm_opp*
In-Reply-To: <20130920123808.GA22176@kahuna>
References: <1379624632-17356-1-git-send-email-nm@ti.com>
 <1379624632-17356-2-git-send-email-nm@ti.com>
 <CAKohpoku7n6b2dDKD=+3DqG4pHtmWoeXZnAt3EoFRp+rNFofYA@mail.gmail.com>
 <20130920123808.GA22176@kahuna>
Message-ID: <CAKohpoktS4ZSQAeKvu3hdVsKkzcbKFvHvR2=wCA3qeB6moPphA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 September 2013 18:08, Nishanth Menon <nm@ti.com> wrote:

> I am open to suggestions if any one feels we can improve this better.

I didn't really had one.. I thought of pm_opp** instead of dev_pm_opp**
though..

> I believe that change was from Patch #2[1]

Yeah.. I just replied on a single patch :)

> yes, you are right, I had squashed this patch in to squelch checkpatch
> warnings:

I see..

> I had added a comment:
> " Minor checkpatch warning fixes as a result of this change was fixed as
> well."

I really missed that..

> Would you suggest I split the change off to a separate patch or improve
>  the comment a little more?

don't really know, maybe leave those as is and let checkpatch warn you..
