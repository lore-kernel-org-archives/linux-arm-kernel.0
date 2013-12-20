From: olof@lixom.net (Olof Johansson)
Date: Fri, 20 Dec 2013 13:22:06 -0800
Subject: [PATCH 1/2] ARM: EXYNOS: Support Suspend-to-RAM on EXYNOS5420
In-Reply-To: <CAM4voamD4Cj594fbkciNS32U7PSkByxakZmjPnhFo0mpCj8hug@mail.gmail.com>
References: <1387195271-3613-1-git-send-email-a.kesavan@samsung.com>
 <2459303.277Jr8aotM@amdc1032>
 <CAM4voamU5hc7uC5MTOA7OtYuqpsis7cTX3sx0UrmpdZx7_TpzA@mail.gmail.com>
 <CANruHrS1D8d_y43xa-2OGduTvAGWfdeY1REVzZ6YJHjhzLg+hw@mail.gmail.com>
 <CAM4voamD4Cj594fbkciNS32U7PSkByxakZmjPnhFo0mpCj8hug@mail.gmail.com>
Message-ID: <CAOesGMjfcTki4qqD-ZP2zt3ERLRF9DX5_K5rfJXfx1KGa5bG-g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 20, 2013 at 3:38 AM, Abhilash Kesavan
<kesavan.abhilash@gmail.com> wrote:
> Hi Sunil,
>
> On Fri, Dec 20, 2013 at 3:56 PM, sunil joshi <sjoshi.open@gmail.com> wrote:
>> Hi Abhilash,
>> I saw another patch in chrome tree ..by Andrew Bresticker
>> which may be relevant here ..
>>
>> Just wondering if you missed adding this ? or this is not needed ?
>> You did not face any issue in getting core to suspend ?
>
> This has not been added for Exynos5250 in mainline yet. We did notice
> that the system would fail to suspend on the rare occasion (~1% of the
> time on exynos5250) when we repeatedly suspended and resumed the
> system.
>
> I have not run s2r stress tests, but have had no issues suspending the
> system in my limited testing. We can probably let this be for now as
> the system would resume fine even on a failed suspend. I will do some
> stress testing and then post if needed.

Hold on, you're claiming that this patch you've posted has only seen
very limited testing, and that you are aware of failures?

Don't merge known-broken code into the mainline kernel.


-Olof
