From: fan.chen@mediatek.com (Fan Chen)
Date: Tue, 2 Feb 2016 10:17:42 +0800
Subject: MTK mt8173-evb: mainline unstable, and big-endian boot failures
In-Reply-To: <7hh9hrgbbh.fsf@baylibre.com>
References: <CAOi56cVDbkAJEDWy3+DV63a=UuD7nqpUu8X7e-OjtWM-4dj_-w@mail.gmail.com>
 <7hsi1ilczm.fsf@baylibre.com>
 <CAF-23O3ps0Wt_UCmJbArpc5iJJryJKA0k_2qAyNb7op8O=UnAg@mail.gmail.com>
 <1453964180.26397.8.camel@mtksdaap41> <7hy4b8gc7q.fsf@baylibre.com>
 <1454309376.11974.3.camel@mtksdaap41> <7hh9hrgbbh.fsf@baylibre.com>
Message-ID: <1454379462.27798.11.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

I just checked that the problem cannot be reproduced (tested 100 times
with your script) after flashing new firmware which we uploaded to
github[0] yesterday.
This latest firmware got many fixes and also supports cluster idle, so
we prefer testing with this new one
Would you please test in your side? Thanks for your great help!! 

[0] https://github.com/ibanezchen/evb-utils/tree/master


Best regards,
Fan

On Mon, 2016-02-01 at 17:17 -0800, Kevin Hilman wrote:
> Hi Eddie,
> 
> Eddie Huang <eddie.huang@mediatek.com> writes:
> 
> [...]
> 
> > Thanks your patience to provide detail steps, we can reproduce this
> > problem now. It seems something wrong in ATF, we still investigate how
> > to fix it. We will provide you new ATF firmware once we have solution
> 
> Great, I'm glad you can reproduce it.  I was starting to worry it was
> only my hardware with the problem.
> 
> Please let me know if there are firmware updates you'd like me to test
> and I'll be happy to.
> 
> Thanks,
> 
> Kevin
