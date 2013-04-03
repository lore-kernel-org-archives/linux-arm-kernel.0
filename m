From: dianders@chromium.org (Doug Anderson)
Date: Wed, 3 Apr 2013 10:20:56 -0700
Subject: [PATCH 0/2] These two patches to s3c_pm_arch_prepare_irqs() were
 part of the work
In-Reply-To: <24b501ce3011$454d3c70$cfe7b550$%kim@samsung.com>
References: <1363711900-25560-1-git-send-email-dianders@chromium.org>
 <24b401ce300f$5a767b40$0f6371c0$%kim@samsung.com>
 <24b501ce3011$454d3c70$cfe7b550$%kim@samsung.com>
Message-ID: <CAD=FV=XTMbs9q5FvsFUTmCDrFu7q-ngnS3F94cHNnCRmN3UNLg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kukjin,

On Tue, Apr 2, 2013 at 7:16 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
>> Applied with 1st one, BTW, do you want to send this for stable tree?

I don't have any need for it to be in stable tree.  The ARM Chromebook
hasn't reached critical functionality on any released/upstram Linux
versions so it doesn't make much sense to backport fixes.  If someone
else wants it in stable (and can confirm that it helps them) then I
certainly wouldn't object!


> One more note, just now I discussed Jaecheol Lee about the bit,
> ENABLE_WAKEUP_SW, as the patch fixed, it should be cleared but used to be
> set s3c_irqwake_intmask. Let me check again, then if any updates I'll let
> you know.

OK, thanks.  If there is a reason that ENABLE_WAKEUP_SW needs to be
set then it would be good to understand that case.  :)

-Doug
