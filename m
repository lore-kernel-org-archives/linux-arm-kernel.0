From: inki.dae@samsung.com (Inki Dae)
Date: Wed, 26 Sep 2012 13:32:10 +0900
Subject: [PATCH V6 2/2] video: drm: exynos: Add device tree support
In-Reply-To: <20120925153109.GA8834@sirena.org.uk>
References: <1348226536-22899-1-git-send-email-l.krishna@samsung.com>
 <505C9072.2010204@wwwdotorg.org>
 <CAAQKjZMZBDpKinZkDUX7CU4yTXmu9GrP1+OiZJKW4Gx1BTno3Q@mail.gmail.com>
 <2368486.hLKA5vLF0M@avalon>
 <CAAQKjZN++zZ9cfNCB21TeQwPZgFVU-Cmo9ZhVwaaMz+HO2vHig@mail.gmail.com>
 <20120925153109.GA8834@sirena.org.uk>
Message-ID: <CAAQKjZNRJHuA4+B-tP5vTaDfmMMxC+VKLDJU4gtpvtu=srzgAg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/9/26 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> On Wed, Sep 26, 2012 at 12:03:44AM +0900, Inki Dae wrote:
>> 2012/9/25 Laurent Pinchart <laurent.pinchart@ideasonboard.com>:
>
>> > Aren't DT bindings considered as an ABI, and required to be supported more or
>> > less forever ? If you merge this DT binding you'll have to keep supporting it.
>> > That's why DT bindings should not be rushed in.
>
>> is ABI required for DT binding?  I know DT binding parses just lcd
>> timing data from device tree file so ABI isn't needed. but when it
>> comes to DT, I'm novice yet so there may be my missing point. could
>> you tell me why DT bindings are considered as an ABI? if there is my
>> missing point, will consider it again.
>
> It's supposed to be possible to ship a DT with a board and then boot any
> OS or OS version on the board.  If the meaning of the DT keeps changing
> then this becomes impossible, you need to keep changing the DT when you
> change the thing that parses it (rendering the whole exercise pointless).
>

thank you for your comments. got it. DT is built as an binary(dtb) and
the dtb file should be re-used without any modifications. will keep
this patch until the videomode helper will be merged to mainline so
that this could be modified based on videomode helper later.

> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
