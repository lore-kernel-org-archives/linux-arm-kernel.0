From: maxin.john@gmail.com (Maxin B. John)
Date: Thu, 7 Mar 2013 11:31:02 +0100
Subject: [PATCH] dma: Remove erroneous __exit and __exit_p() references
In-Reply-To: <20130307094735.GG13370@intel.com>
References: <1361318824-22287-1-git-send-email-maxin.john@gmail.com>
 <CACRpkdZamOCWHWMcFYRqQDKJARZOCEP_eSNPNaxSgHfAn2wmEw@mail.gmail.com>
 <CAMhs6YwC+Lx0Vt=w2MoQV08on+rB1zidGCsNHRqcst8KBrb2XQ@mail.gmail.com>
 <20130307094735.GG13370@intel.com>
Message-ID: <CAMhs6Yw12NvB1VUYUZq48jtSHMpx-jCyGyi-U0vQ_5eNE3_mjA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,

On Thu, Mar 7, 2013 at 10:47 AM, Vinod Koul <vinod.koul@intel.com> wrote:
> On Thu, Mar 07, 2013 at 10:17:40AM +0100, Maxin B. John wrote:
>> Hi,
>>
>> On Fri, Feb 22, 2013 at 7:29 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
>> > On Wed, Feb 20, 2013 at 1:07 AM,  <maxin.john@gmail.com> wrote:
>> >
>> >> From: "Maxin B. John" <maxin.john@enea.com>
>> >>
>> >> Removing the annotation with __exit and referencing with __exit_p()
>> >> present in dma driver module remove hooks.
>> >>
>> >> Part of the __devexit and __devexit_p() purge.
>> >>
>> >> Signed-off-by: Maxin B. John <maxin.john@enea.com>
>> >
>> > Acked-by: Linus Walleij <linus.walleij@linaro.org>
>>
>> Gentle ping...
> ???
>
> Its already in my -next
In that case, sorry for creating confusion. I was under the impression
that only the patch titled "dma: timb_dma: Fix compiler warning" was
accepted in "-next".

> ~Vinod
Warm Regards,
Maxin
