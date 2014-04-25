From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 25 Apr 2014 13:18:28 +0200
Subject: [PATCH 00/38] MMC updates, plus CuBox-i WiFi support
In-Reply-To: <20140425090343.GH26756@n2100.arm.linux.org.uk>
References: <20140423185534.GA26756@n2100.arm.linux.org.uk>
 <CAPDyKFozP69yngKAkdwHYyyvi+pdLEm05udOmBiVshQFi4hnLQ@mail.gmail.com>
 <20140424101726.GH26756@n2100.arm.linux.org.uk>
 <CAPDyKFrGReKF0ucer7D195boEoQW26=4vDXT+=Wn6BO-p_B1gQ@mail.gmail.com>
 <20140424105745.GM26756@n2100.arm.linux.org.uk>
 <CAPDyKFr=2=dg1NTYb1_EAgxXZq2Rd+o2Q2B5TE+GZwr8MUU1_Q@mail.gmail.com>
 <20140425090343.GH26756@n2100.arm.linux.org.uk>
Message-ID: <CAPDyKFpAiegwfh=kA8NyB+DdwKT=wSGJsB=gbEgLbyv0RJ2EOQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25 April 2014 11:03, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> On Thu, Apr 24, 2014 at 01:13:05PM +0200, Ulf Hansson wrote:
>> On 24 April 2014 12:57, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
>> > This is nothing new or unexpected - it was last posted back in February,
>> > and I elected that it should be held off until after the last merge
>> > window.
>> >
>> > Unfortunately, I didn't have time to post it immediately after the merge
>> > window closed, partly because it needed to be rebased on top of tglx's
>> > IRQ changes on which it depends.  I was carrying those as separate commits
>> > to the ones Thomas was carrying in his tree - and in the event, Thomas had
>> > modified his patches slightly between sending me copies of them and the
>> > versions he sent during the merge window.
>>
>> Okay, so let's keep up the frequency here then. I only had some minor
>> comments, please fix them and send a v2.
>
> Right, so I've updated the patches, and added one ack to one patch.
> That seems insufficient to me - the only platform these have been
> tested on is iMX6, which is sdhci-esdhc-imx.c.
>
> They _really_ need testing elsewhere too.  Or is the plan to merge
> them and then see about getting people to test them and fix them up
> afterwards?

I was hoping people could start doing tests, before Chris actually
decided to pull them in. Now, if that doesn't happen, we could just
merge them, as you say, and thus we have to fix potential problems
afterwards. I would expect you to help out if problem occurs.

If we decide to not merge in a while, I am not sure how long we could
prevent other sdhci patches from being merged. I guess Chris will have
to take the final call.

>
> --
> FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
> improving, and getting towards what was expected from it.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
