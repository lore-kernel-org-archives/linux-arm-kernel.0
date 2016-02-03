From: fan.chen@mediatek.com (Fan Chen)
Date: Wed, 3 Feb 2016 09:38:18 +0800
Subject: MTK mt8173-evb: mainline unstable, and big-endian boot failures
In-Reply-To: <7h37tbdk6y.fsf@baylibre.com>
References: <CAOi56cVDbkAJEDWy3+DV63a=UuD7nqpUu8X7e-OjtWM-4dj_-w@mail.gmail.com>
 <7hsi1ilczm.fsf@baylibre.com>
 <CAF-23O3ps0Wt_UCmJbArpc5iJJryJKA0k_2qAyNb7op8O=UnAg@mail.gmail.com>
 <1453964180.26397.8.camel@mtksdaap41> <7hy4b8gc7q.fsf@baylibre.com>
 <1454309376.11974.3.camel@mtksdaap41> <7hh9hrgbbh.fsf@baylibre.com>
 <1454379462.27798.11.camel@mtksdaap41> <7h37tbdk6y.fsf@baylibre.com>
Message-ID: <1454463498.27798.24.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

On Tue, 2016-02-02 at 10:46 -0800, Kevin Hilman wrote:
> Hi Fan,
> 
> Fan Chen <fan.chen@mediatek.com> writes:
> 
> > I just checked that the problem cannot be reproduced (tested 100 times
> > with your script) after flashing new firmware which we uploaded to
> > github[0] yesterday.
> 
> Great news!
> 
> > This latest firmware got many fixes and also supports cluster idle, so
> > we prefer testing with this new one Would you please test in your
> > side? Thanks for your great help!!
> 
> I tested the latest firmware and it's booted 20+ times in a row without
> failure, which is better than it ever did in the past, so it seems to
> have fixed the idle problem.
> 
> I will keep an eye on the failures in kernelci.org and let you know if I
> notice any other failures.
> 
> Thanks again for the updated firmware!
> 
Thanks to keep notice us failures as well.

> Speaking of updated firmware, is there any chance to make the default
> version of the firmware significantly less noisy.  There is a TON of
> output from the firmware before fastboot starts which makes the logs for
> this board very noisy (same complaint on the mt8135.)
> 
I will discuss with Eddie if it's possible to release a version with
light logs, but I'm afraid the answer could be given after our Chinese
New Year vacation. :P
 

> Kevin
> 

Fan
