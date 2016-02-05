From: keescook@chromium.org (Kees Cook)
Date: Fri, 5 Feb 2016 12:42:30 -0800
Subject: [PATCH v5sub2 0/8] arm64: implement virtual KASLR
In-Reply-To: <CAKv+Gu_v1sXM7sivz+Uu86ZG3=Th7wqqh7M1N8wF7Ess4NdTZQ@mail.gmail.com>
References: <1454332178-4414-1-git-send-email-ard.biesheuvel@linaro.org>
 <CAKv+Gu-AhLcatkDsQVeoFGJ+pTEwaW1Hy9M-fY1-VWvRc_E47w@mail.gmail.com>
 <20160205173248.GJ6076@e104818-lin.cambridge.arm.com>
 <CAKv+Gu_v1sXM7sivz+Uu86ZG3=Th7wqqh7M1N8wF7Ess4NdTZQ@mail.gmail.com>
Message-ID: <CAGXu5j+JpwRrVy1b_h+LJ4sCzsT7BV9RdcD0CvR-4aVJQhCpvg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 5, 2016 at 9:38 AM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> On 5 February 2016 at 18:32, Catalin Marinas <catalin.marinas@arm.com> wrote:
>> I'm still trying to get my head around how we merge those. Since I
>> assume akpm will push them during the merging window, part of your code
>> cannot be tested before.
>
> Actually, my original idea was for akpm to take them as a late merge
> after rebasing to -rc1, since they touch a variety of architectures,
> but I am not sure if that came across.
>
> You could always take the series through your tree instead, I guess?

Traditionally akpm will de-duplicate patches he's carrying that appear
in another tree. I think it should be okay to carry them in both
places. (Though I'm CCing akpm just to see if I'm talking crazy.)

-Kees

-- 
Kees Cook
Chrome OS & Brillo Security
