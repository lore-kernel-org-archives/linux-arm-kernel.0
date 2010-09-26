From: kmpark@infradead.org (Kyungmin Park)
Date: Sun, 26 Sep 2010 19:53:48 +0900
Subject: [PATCH] sdhci-s3c: fix NULL ptr access in sdhci_s3c_remove
In-Reply-To: <20100925225324.GA30732@void.printf.net>
References: <1285251725-6210-1-git-send-email-m.szyprowski@samsung.com>
	<20100923120803.832975f6.akpm@linux-foundation.org>
	<20100925225324.GA30732@void.printf.net>
Message-ID: <AANLkTikXX4eUEKmBMOH1PuioGgztGN4jKPnPBDqf=4zf@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 26, 2010 at 7:53 AM, Chris Ball <cjb@laptop.org> wrote:
> On Thu, Sep 23, 2010 at 12:08:03PM -0700, Andrew Morton wrote:
>> The patch applies OK to 2.6.35. ?Is the bug present there as well? ?If
>> so, should we fix it in earlier kernels? ?If so then the way in which
>> we indicate this is by adding
>>
>> ? ? ? Cc: <stable@kernel.org>
>>
>> to the changelog.
>
> Marek, Kyungmin, what do you think?

Of course my opinion is should be merged at this time.
In normal case it's built as static module. so there's no complains.
but it should be fixed.
My SOB is already included at patch. so no need to ACK from me.

Thank you,
Kyungmin Park
>
> Andrew, I've been waiting for an ACK from Ben Dooks, since he's listed
> in MAINTAINERS for this driver, but he hasn't replied yet (I've tried
> pinging privately). ?I'll plan on sending Marek's two s3c fixes to
> Linus tomorrow regardless (this one with Cc: <stable@kernel.org>)
> along with my MAINTAINERS update for MMC unless anyone objects.
>
> Thanks,
>
> --
> Chris Ball ? <cjb@laptop.org> ? <http://printf.net/>
> One Laptop Per Child
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>
