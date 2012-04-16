From: kyungmin.park@samsung.com (Kyungmin Park)
Date: Mon, 16 Apr 2012 19:01:32 +0900
Subject: [PATCH 0/2] Exynos: fix SYSMMU driver to work with power domains
In-Reply-To: <CAHQjnOOws9imNo-S4prfHdqXjghotFaw_tqi81jNzHVPn8dXLg@mail.gmail.com>
References: <1334154871-4756-1-git-send-email-m.szyprowski@samsung.com>
 <CAHQjnOOGWVcc95F==1__SCH0S-mX8bvRwOr7MhB3Arw=83jZMw@mail.gmail.com>
 <4F899D18.6000700@samsung.com>
 <CAHQjnOOws9imNo-S4prfHdqXjghotFaw_tqi81jNzHVPn8dXLg@mail.gmail.com>
Message-ID: <CAH9JG2VuBTp30KQGeKUsdQZKuPeAMj8XvGHdH-8r=XA5F2a5qg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/16/12, KyongHo Cho <pullip.cho@samsung.com> wrote:
> On Sun, Apr 15, 2012 at 12:51 AM, Kukjin Kim <kgene.kim@samsung.com> wrote:
>> On 04/12/12 01:19, KyongHo Cho wrote:
>>>
>>> On Wed, Apr 11, 2012 at 11:34 PM, Marek Szyprowski
>>> <m.szyprowski@samsung.com>  wrote:
>>>>
>>>> Hi!
>>>>
>>>> These two patches fixes operation of the SYSMMU driver (v12 version [1])
>>>> with the new power domain driver based on generic power domains and
>>>> runtime pw, which has been merged to Linux kernel v3.4-rc1.
>>>>
>>> Thanks, Marek.
>>>
>>> Your way of power gating is right
>>> and I will look into the changed runtime PM scheme in Exynos tree.
>>>
>> KyongHo,
>>
>> Do you want to upstream this series with your previous sysmmu (cleanup and
>> moving) patches?
>>
>
> Yes I hope so.
> Marek's patch corrects run-time power management in Exynos4 with System MMU.

Hi,

Next time, if you give Acked-By or Reviewed_by, then it's more helpful
to determine to merge or not.

Thank you,
Kyungmin Park
>
> Thank you.
>
> KyongHo
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc"
> in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
