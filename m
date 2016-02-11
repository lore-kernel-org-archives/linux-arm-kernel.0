From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu, 11 Feb 2016 16:13:44 +0100
Subject: [PATCH 1/7] mmc: omap_hsmmc: Fix PM regression with deferred
 probe for pm_runtime_reinit
In-Reply-To: <20160211150240.GR19432@atomide.com>
References: <1455145370-20301-1-git-send-email-tony@atomide.com>
 <1455145370-20301-2-git-send-email-tony@atomide.com>
 <CAPDyKFpAcsfLgtu93P45fTEg11MjdGwREcyeGSS7vt6GWbNu_w@mail.gmail.com>
 <20160211150240.GR19432@atomide.com>
Message-ID: <CAPDyKFo4Jyjwyvr3P5VHfDhQ87K9mnR01N-NtKz-yx2ycnfOLg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 February 2016 at 16:02, Tony Lindgren <tony@atomide.com> wrote:
> * Ulf Hansson <ulf.hansson@linaro.org> [160211 02:19]:
>> On 11 February 2016 at 00:02, Tony Lindgren <tony@atomide.com> wrote:
>> >
>> > Ulf, I'd like to merge this along with other related fixes via the
>> > ARM SoC tree if no objections, please review and ack if this look OK
>> > to you.
>>
>> I have some other omap_hsmmc patches queued for 4.6, so I prefer to
>> send this via my mmc tree.
>>
>> I guess that's okay as well!?
>
> Naturally yes, please go ahead thanks!

Okay!

BTW, did you notice my other comments to the patch?

I can fix them before applying, unless you want to send a v2?

Kind regards
Uffe
