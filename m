From: jason.wessel@windriver.com (Jason Wessel)
Date: Thu, 15 Sep 2016 07:32:19 -0500
Subject: [RESEND PATCH] arm64: kgdb: fix single stepping
In-Reply-To: <5fd52bac-a303-81c8-1b91-daa55d6cd53f@linaro.org>
References: <1429578793-3971-1-git-send-email-takahiro.akashi@linaro.org>
 <20160914145850.GE19622@arm.com> <20160915075617.GJ16712@linaro.org>
 <5fd52bac-a303-81c8-1b91-daa55d6cd53f@linaro.org>
Message-ID: <13e67804-c904-202b-acc0-ffc839e4d6ab@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/15/2016 05:41 AM, Daniel Thompson wrote:
> On 15/09/16 08:56, AKASHI Takahiro wrote:
>> On Wed, Sep 14, 2016 at 03:58:51PM +0100, Will Deacon wrote:
>>> Hi Akashi,
>>>
>>> On Tue, Apr 21, 2015 at 02:13:13AM +0100, AKASHI Takahiro wrote:
>>>> Could you please review my patch below?
>>>> See also arm64 maintainer's comment:
>>>> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/313712.html
>>>
>>> -ETIMEDOUT waiting for the kdgb folk to comment. Ppeople have reported
>>> that this patch is required for kgdb to work correctly on arm64, so I'm
>>> happy to merge it.
>>
>> I'm happy, too.
>
> I'll keep an eye out and FWIW see if I can throw in a review. I'm not
> really one of "kgdb folk" but did examine it fairly deeply in the early
> stages of the FIQ/NMI work (and which has since stopped focussing on kgdb).
>
> I have some equally elderly, albeit rather less critical, kdb patches
> that I should have pushed harder for so I'm sympathetic here ;-)


Hey, if you do happen to have something, why not send it along.  I just asked the linux-next folks to re-activate the kgdb-next branch so that merges can start taking place again.  It appears that the final merge request never even went through from linux-next as I just rebased it and there was a patch in there from Daniel dating back to over a year ago.

If there is work out there that needs merging and reviews lets get it done.  I had been kind of stuck in time on what seems like the stone age 3.14 kernel projects until recently, but jumped back into mainline development about a month ago.

I have no objection to merging the ARM64 single step patch and have comments in a separate mail that follows with respect to the patch.


Cheers,
Jason.
