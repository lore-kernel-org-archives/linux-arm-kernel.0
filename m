From: inki.dae@samsung.com (Inki Dae)
Date: Thu, 06 Apr 2017 15:48:37 +0900
Subject: [PATCH v5 3/5] drm/exynos: dsi: Fix the parse_dt function
In-Reply-To: <CAJKOXPd-h4QqLXJ5AYr1KgpjvROaWpVZnd9KmeeGoVRQifssbw@mail.gmail.com>
References: <1488948852-5380-1-git-send-email-hoegeun.kwon@samsung.com>
 <CGME20170308045502epcas1p2d2f7a0f768082b7a54b2ebe260e78436@epcas1p2.samsung.com>
 <1488948852-5380-4-git-send-email-hoegeun.kwon@samsung.com>
 <93e79e92-a102-e931-8d63-843031848888@samsung.com>
 <58DA1E38.50907@samsung.com>
 <CAJKOXPeD4HKemKTrnC2JaON3JkuNGO9g+Hg8M7F6f2WusiYkhg@mail.gmail.com>
 <CAJKOXPd-h4QqLXJ5AYr1KgpjvROaWpVZnd9KmeeGoVRQifssbw@mail.gmail.com>
Message-ID: <58E5E4C5.5090107@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



2017? 04? 05? 00:38? Krzysztof Kozlowski ?(?) ? ?:
> On Tue, Mar 28, 2017 at 11:38 AM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>> On Tue, Mar 28, 2017 at 11:26 AM, Inki Dae <inki.dae@samsung.com> wrote:
>>> Merged.
>>
>> Hi,
>>
>> I do not see the tag (with DT patches) merged by you which I provided
>> to you before. These are essential for bisectability. Without them,
>> kernel bisectability is broken. Did you merged the tag somewhere?
>>
>> Best regards,
>> Krzysztof
>>
>>> Thanks,
>>> Inki Dae
> 
> Inki,
> 
> I still do not see the DTS tag [1] merged in your tree but you applied
> patches breaking the display. I looked at exynos-drm-next branch.
> 
> We talked already about bisectability and with Hoegeun we provided
> proper solution. Hoegeun split the patchset and I sent you a stable
> tag to merge. Be aware not to apply the DTS patch because you would
> effectively duplicate it. Instead, deal like with any pull request -
> merge the tag as dependency *before* applying DRM DSI patch.
> 
> I saw also a branch like this:
> https://git.kernel.org/pub/scm/linux/kernel/git/daeinki/drm-exynos.git/log/?h=exynos-drm-next-tm2
> but this is something obviously wrong. I do not know what are your
> plans to do with it, but please drop it as it brings only confusion.

Krzysztof,

Do not make you confusing with above branch which is used just for internal test so never go -next maybe you know.
Why are you suffering from this?


Thanks,
Inki Dae

> 
> Best regards,
> Krzysztof
> 
> [1] https://www.spinics.net/lists/arm-kernel/msg567053.html
> 
>>> 2017? 03? 22? 10:36? Hoegeun Kwon ?(?) ? ?:
>>>> Hi inki,
>>>>
>>>> Could you check the this patch?
>>>> For reference, patch 1/5 and 2/5 have already been applied to Krzysztof tree.
>>>>
>>>> Best regards,
>>>> Hoegeun
>>>>
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 
