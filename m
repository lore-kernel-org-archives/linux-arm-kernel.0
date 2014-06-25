From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 25 Jun 2014 14:33:56 +0200
Subject: [PATCH v3 -next 0/9] CMA: generalize CMA reserved area management
 code
In-Reply-To: <20140618135144.297c785260f9e2aebead867c@linux-foundation.org>
References: <1402897251-23639-1-git-send-email-iamjoonsoo.kim@lge.com>
 <539EB4C7.3080106@samsung.com> <20140617012507.GA6825@js1304-P5Q-DELUXE>
 <20140618135144.297c785260f9e2aebead867c@linux-foundation.org>
Message-ID: <53AAC1B4.5000204@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 2014-06-18 22:51, Andrew Morton wrote:
> On Tue, 17 Jun 2014 10:25:07 +0900 Joonsoo Kim <iamjoonsoo.kim@lge.com> wrote:
>>>> v2:
>>>>    - Although this patchset looks very different with v1, the end result,
>>>>    that is, mm/cma.c is same with v1's one. So I carry Ack to patch 6-7.
>>>>
>>>> This patchset is based on linux-next 20140610.
>>> Thanks for taking care of this. I will test it with my setup and if
>>> everything goes well, I will take it to my -next tree. If any branch
>>> is required for anyone to continue his works on top of those patches,
>>> let me know, I will also prepare it.
>> Hello,
>>
>> I'm glad to hear that. :)
>> But, there is one concern. As you already know, I am preparing further
>> patches (Aggressively allocate the pages on CMA reserved memory). It
>> may be highly related to MM branch and also slightly depends on this CMA
>> changes. In this case, what is the best strategy to merge this
>> patchset? IMHO, Anrew's tree is more appropriate branch. If there is
>> no issue in this case, I am willing to develope further patches based
>> on your tree.
> That's probably easier.  Marek, I'll merge these into -mm (and hence
> -next and git://git.kernel.org/pub/scm/linux/kernel/git/mhocko/mm.git)
> and shall hold them pending you review/ack/test/etc, OK?

Ok. I've tested them and they work fine. I'm sorry that you had to wait for
me for a few days. You can now add:

Acked-and-tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

I've also rebased my pending patches onto this set (I will send them soon).

The question is now if you want to keep the discussed patches in your 
-mm tree,
or should I take them to my -next branch. If you like to keep them, I assume
you will also take the patches which depends on the discussed changes.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
