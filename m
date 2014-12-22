From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 22 Dec 2014 15:57:47 +0100
Subject: [PATCH] clk: samsung: exynos7: Add clocks for MSCL block
In-Reply-To: <000901d01ddc$eac0d120$c0427360$@samsung.com>
References: <1418801617-7593-1-git-send-email-tony.kn@samsung.com>
 <549450A6.9020205@samsung.com> <000901d01ddc$eac0d120$c0427360$@samsung.com>
Message-ID: <5498316B.9050906@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/12/14 12:46, Tony K Nadackal wrote:
>>> diff --git a/Documentation/devicetree/bindings/clock/exynos7-clock.txt
>>> > > b/Documentation/devicetree/bindings/clock/exynos7-clock.txt
>>> > > index 6d3d5f8..d0e048c 100644
>>> > > --- a/Documentation/devicetree/bindings/clock/exynos7-clock.txt
>>> > > +++ b/Documentation/devicetree/bindings/clock/exynos7-clock.txt
>>> > > @@ -34,6 +34,7 @@ Required Properties for Clock Controller:
>>> > >  	- "samsung,exynos7-clock-peris"
>>> > >  	- "samsung,exynos7-clock-fsys0"
>>> > >  	- "samsung,exynos7-clock-fsys1"
>>> > > +	- "samsung,exynos7-clock-mscl"
>> > 
>> > I can't see anything controversial in the patch, but I've got some doubts
>> > regarding the compatible string. Is there a SoC named just "Exynos7"?
>
> Yes, We have an SoC named Exynos7.
> Please refer http://www.spinics.net/lists/linux-samsung-soc/msg36765.html

I've queued this patch for 3.20. Would be nice to have a Reviewed-by tag
from someone else who has access to the SoC documentation though.

Is Exynos7420 User Manual applicable to this?
Exynos 7 (Octa?) seems like a marketing name to me. In technical documents
there are usually more specific names used, like exynos7410 or exynos7420.

-- 
Regards,
Sylwester
