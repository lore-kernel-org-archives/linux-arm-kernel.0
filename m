From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 10 Aug 2016 13:13:06 -0700
Subject: bcm4708-sr400ac: mainline boot regression
Message-ID: <CAOi56cUEobebbx0=w7VS8DpokDEcu7N585YONW6PMX+KptXWHg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hauke, Rafal,

I noticed (thanks to kernelci.org) that the my sr400ac board started
to fail booting during the merge window, and is still failing at
v4.8-rc1:

   https://kernelci.org/boot/id/57a8441b59b514471448b55a/

I tried to bisect it, but it's not conclusive, and it's making me
think that it's possible related to the kernel image size or load
address issues.

I ran out of time to debug further, but with the link above, you can
see the bisect details towards the bottom showing exactly when it
started to fail, and it includes full boot logs for the passing and
failing boots.

Could either of you have a closer look at this?

Thanks,

Kevin
