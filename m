From: kesavan.abhilash@gmail.com (Abhilash Kesavan)
Date: Thu, 17 Apr 2014 00:40:53 +0530
Subject: [PATCH 3/5] ARM: EXYNOS5420: Add IO mapping for non-secure SYSRAM
In-Reply-To: <5167415.PAy87EVlKC@wuerfel>
References: <1397239311-27717-1-git-send-email-a.kesavan@samsung.com>
 <11327275.EJLfDGG21r@wuerfel>
 <20140414115910.GD3844@e103592.cambridge.arm.com>
 <5167415.PAy87EVlKC@wuerfel>
Message-ID: <CAM4voakCOLSATeG1CX__cwNNW_mMcdjNh0EVtqim61v2JSp7rQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dave and Arnd,

On Mon, Apr 14, 2014 at 6:54 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 14 April 2014 12:59:11 Dave Martin wrote:
>> On Mon, Apr 14, 2014 at 01:47:56PM +0200, Arnd Bergmann wrote:
>> > On Monday 14 April 2014 12:25:20 Dave Martin wrote:
>> > > Arnd, what was your preferred solution?  Should this be described in DT?
>> >
>> > Yes. There are already patches on the list to do this right.
>>
>> This is http://www.spinics.net/lists/linux-samsung-soc/msg27647.html,
>> right?
>>
>> If so, it looks like exynos5420 should definitely follow the same
>> approach.
>>
>
> Yes, exactly.

I'll make use of the SYSRAM dt patch in my next patchset.
>
>         Arnd
Regards,
Abhilash
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
