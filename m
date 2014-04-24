From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu, 24 Apr 2014 12:52:11 +0200
Subject: [PATCH 00/38] MMC updates, plus CuBox-i WiFi support
In-Reply-To: <20140424101726.GH26756@n2100.arm.linux.org.uk>
References: <20140423185534.GA26756@n2100.arm.linux.org.uk>
 <CAPDyKFozP69yngKAkdwHYyyvi+pdLEm05udOmBiVshQFi4hnLQ@mail.gmail.com>
 <20140424101726.GH26756@n2100.arm.linux.org.uk>
Message-ID: <CAPDyKFrGReKF0ucer7D195boEoQW26=4vDXT+=Wn6BO-p_B1gQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 April 2014 12:17, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> On Thu, Apr 24, 2014 at 10:25:42AM +0200, Ulf Hansson wrote:
>> I have looked though the patches up until patch 33 and this is clearly
>> a nice piece of clean-up /fixes work for sdhci. Besides my minor
>> comments per patch, I don't have any objections code-review wise to
>> proceed merging them.
>>
>> I have also tried to applied them on Chris' mmc-next branch,
>> unfortunate it fails at patch 23, so it would be nice to get a
>> re-based patchset for the mmc-next branch.
>
> I /could/ rebase it but then I wouldn't be able to produce the patch
> sets/patches for others [*] (such as the Novena project) to derive
> their kernel tree from my iMX6 patch set.
>
> What I'd prefer is to keep the patch set intact, and provide Chris
> with a pull request for it up to patch 33, which would need a
> conflict fixed - and this would mean that I can be sure that what
> I'm testing, and what I'm distributing is what Chris will also be
> submitting.

Whether there are more than one conflict, I don't know. I just stopped
at patch 23.

Moreover, there are other patches for sdhci that have been posted and
being discussed. In principle, we then need to put all these on hold
to prevent further conflicts. I guess that doable, as long as we don't
to that for too long. Maybe Chris have some more thoughts how to
handle this!?

Kind regards
Ulf Hansson

>
> * - this currently stands at 230 patches in all - mmc + l2c + fec +
>     imx-drm + other iMX6 changes.
>
> --
> FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
> improving, and getting towards what was expected from it.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
