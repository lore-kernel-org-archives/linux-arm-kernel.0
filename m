From: kesavan.abhilash@gmail.com (Abhilash Kesavan)
Date: Fri, 24 Oct 2014 20:02:58 +0530
Subject: [PATCH v5 0/8] arch: arm64: Enable support for Samsung Exynos7 SoC
In-Reply-To: <CAM4voak5DpRHghgF=EdmPCHeenMFZQeOTsm9QLE1fSXDoM1a+g@mail.gmail.com>
References: <1411361228-18279-1-git-send-email-a.kesavan@samsung.com>
 <541FE357.5090000@gmail.com>
 <CAM4voa=Hsux0+rccSvDJsNTFakZwuwYwjkDkkNFfndFm03Pn3g@mail.gmail.com>
 <542AD2AE.6060109@gmail.com>
 <01a501cfe1e5$759fc8c0$60df5a40$@kernel.org>
 <CAM4voak5DpRHghgF=EdmPCHeenMFZQeOTsm9QLE1fSXDoM1a+g@mail.gmail.com>
Message-ID: <CAM4voanMX__N6=q8gg1LEGxqGTtByJXPdj+oAucHoyDh5ybaEA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+Sylwester

On Wed, Oct 8, 2014 at 11:18 AM, Abhilash Kesavan
<kesavan.abhilash@gmail.com> wrote:
> Hi Tomasz,
>
> On Tue, Oct 7, 2014 at 9:46 AM, Kukjin Kim <kgene@kernel.org> wrote:
>> Tomasz Figa wrote:
>>>
>>> On 30.09.2014 17:12, Abhilash Kesavan wrote:
>>> > Hi Tomasz,
>>> >
>>> > On Mon, Sep 22, 2014 at 2:22 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
>>> >> Hi Abhilash,
>>> >>
>>> >> On 22.09.2014 06:47, Abhilash Kesavan wrote:
>>> >>> Changes since v4:
>>> >>> - Fixed comments from Tomasz Figa:
>>> >>>       - Changed the namespace prefix from exynos to samsung
>>> >>>       - Defined bindings to take all input clocks
>>> >>>       - Sorted the Kconfig entries alphabetically in clock Makefile
>>> >>>       - Used consistent 1 tab line breaks across the clock file
>>> >>>       - Statically initialized the samsung_cmu_info struct
>>> >>> - Enabled exynos7 in the arm64 defconfig as per Catalin Marinas' comment.
>>> >>> - Added Kukjin Kim's ack along with Thomas Abraham's tested and reviewed tags.
>>> >>>
>>> >>
>>> >> The clock patches look good to me, but since they are doing quite a lot
>>> >> of code moving I'd prefer to take them through clk tree. Based on the
>>> >> fact that there are no code dependencies between clock patches and
>>> >> remaining ones and Exynos7 is a new material for 3.18, I'm inclined to
>>> >> apply them to my tree if nobody minds.
>>> >
>>> > Will you be picking up the clock changes soon ?
>>>
>>> I'd like to do so. Kukjin, since clock changes are a part of this
>>> series, might I have your Ack for them to be applied separately?
>>>
>> Sure, I'm fine so please go ahead with my ack on the changes.
>>
>> Acked-by: Kukjin Kim <kgene.kim@samsung.com>
>>
>> Thanks for your asking.
>
> Can you please pick up the clock changes now that Kukjin has ack'ed it.

Sylwester, you mentioned in another thread that Tomasz might not be
available for the next few days. Could you please consider applying
the clock changes in this series to samsung clk-next if they look OK ?

Please take a look at clock changes at
http://www.spinics.net/lists/arm-kernel/msg370673.html too.

Regards,
Abhilash
