From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Tue, 30 Sep 2014 17:56:30 +0200
Subject: [PATCH v5 0/8] arch: arm64: Enable support for Samsung Exynos7 SoC
In-Reply-To: <CAM4voa=Hsux0+rccSvDJsNTFakZwuwYwjkDkkNFfndFm03Pn3g@mail.gmail.com>
References: <1411361228-18279-1-git-send-email-a.kesavan@samsung.com>	<541FE357.5090000@gmail.com>
 <CAM4voa=Hsux0+rccSvDJsNTFakZwuwYwjkDkkNFfndFm03Pn3g@mail.gmail.com>
Message-ID: <542AD2AE.6060109@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30.09.2014 17:12, Abhilash Kesavan wrote:
> Hi Tomasz,
> 
> On Mon, Sep 22, 2014 at 2:22 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
>> Hi Abhilash,
>>
>> On 22.09.2014 06:47, Abhilash Kesavan wrote:
>>> Changes since v4:
>>> - Fixed comments from Tomasz Figa:
>>>       - Changed the namespace prefix from exynos to samsung
>>>       - Defined bindings to take all input clocks
>>>       - Sorted the Kconfig entries alphabetically in clock Makefile
>>>       - Used consistent 1 tab line breaks across the clock file
>>>       - Statically initialized the samsung_cmu_info struct
>>> - Enabled exynos7 in the arm64 defconfig as per Catalin Marinas' comment.
>>> - Added Kukjin Kim's ack along with Thomas Abraham's tested and reviewed tags.
>>>
>>
>> The clock patches look good to me, but since they are doing quite a lot
>> of code moving I'd prefer to take them through clk tree. Based on the
>> fact that there are no code dependencies between clock patches and
>> remaining ones and Exynos7 is a new material for 3.18, I'm inclined to
>> apply them to my tree if nobody minds.
> 
> Will you be picking up the clock changes soon ?

I'd like to do so. Kukjin, since clock changes are a part of this
series, might I have your Ack for them to be applied separately?

Best regards,
Tomasz
