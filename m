From: syin@broadcom.com (Sherman Yin)
Date: Thu, 22 Aug 2013 00:43:10 +0000
Subject: [PATCH] pinctrl: Pass all configs to driver on
 pin_config_set()
In-Reply-To: <CACRpkdaUacAbLd+i4Y=DXv=aSaUwBSz6-icPV9SVjxZkUjheww@mail.gmail.com>
References: <1376606573-15093-1-git-send-email-syin@broadcom.com>
 <CACRpkdaUacAbLd+i4Y=DXv=aSaUwBSz6-icPV9SVjxZkUjheww@mail.gmail.com>
Message-ID: <051069C10411E24D9749790C498526FA1BDD9D27@SJEXCHMB12.corp.ad.broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

>Right now this does not apply to my "devel" branch, so I'd like you
>to rebase on that right now. (This is what will go into v3.12).
>
>This is also late in the development cycle so I believe this is going to
>be v3.13 material unless there are more release candidates.
>
>You can also hold on until after the v3.12 merge window and then
>rebase it and we'll merge it as a first patch in the v3.13 development
>cycle.
>
>What do you say?

You mean the "devel" branch in this tree, right?  Please let me know 
if you're talking about another tree/branch.

git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git

I cherry-picked my commit on top of devel, and there was just a simple
conflict in pinctrl-sunxi.c.  It's easy enough to fix, so I'll send out v2 
that's based on "devel" instead of rc6 anyway.  I can just do another
rebase after v3.12 merge window if needed. 

Thanks!
Sherman
