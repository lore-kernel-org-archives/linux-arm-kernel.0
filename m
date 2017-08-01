From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue, 1 Aug 2017 14:11:38 +0200
Subject: [GIT PULL] Meson clock fixes for 4.13-rc4
In-Reply-To: <20170801013800.GL2146@codeaurora.org>
References: <ce41382f-fd93-1dc9-0dba-1484ac555945@baylibre.com>
 <20170731202031.GK2146@codeaurora.org> <1501537388.2759.7.camel@baylibre.com>
 <20170801013800.GL2146@codeaurora.org>
Message-ID: <3492f1fe-c4d6-034c-1914-ec7e702f5bcc@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/01/2017 03:38 AM, Stephen Boyd wrote:
> On 07/31, Jerome Brunet wrote:
>> On Mon, 2017-07-31 at 13:20 -0700, Stephen Boyd wrote:
>>> On 07/31, Neil Armstrong wrote:
>>>> Hi Mike, Stephen,
>>>>
>>>> Here is some fixes for Meson GXBB and Meson8 drivers, that could go for
>>>> 4.13-rc4.
>>>>
>>>
>>> Are any of these critical fixes for regressions in the v4.13-rc
>>> series? All the Fixes tags look like they go back to before
>>> v4.13-rc1, so they don't look critical at first glance. If
>>> anything, they're mostly nice to have non-critical fixes? If so,
>>> can we defer these until the next merge window?
>>
>> I agree that these fixes hardly qualify as critical, except maybe for the mpll
>> fix. The clock rate actually applied can be really off compared to what CCF will
>>  except to have set.
> 
> Ok. So perhaps just the mpll fix would be appropriate then?
> 
>>
>> These fixes are quite simple and safe, it would be nice if we could avoid having
>>  the next version tagged with known issues.
>>
> 
> I agree they're simple and safe, but they're also not necessary
> to the release we're working on unless they're causing some
> problem with code that was introduced this merge window. We try
> to avoid merging non-critical fixes unless they're really causing
> someone some sort of problems. If they aren't, we can stick them
> into linux-next and wait until next release. Of course, they'll
> be backported to stable trees as well with the Fixes tag, so
> everything works out in the end.
> 

OK, I'll resend a v2 PR with only the mpll fix.

The other will be pushed on our next/drivers branch.

Neil
