From: arno@natisbad.org (Arnaud Ebalard)
Date: Thu, 19 Dec 2013 17:34:09 +0100
Subject: Can someone Ack and queue a patch for RTC subsytem?
Message-ID: <87siton6ke.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I have a very simple driver (support for reading and setting the time)
for a RTC chip (Intersil ISL 12057) but cannot find anyone to get it
Acked and queued for v3.14. In v3.14, there should be at least three
users of the driver (ReadyNAS 102, 104 and 2120) if I meet -rc5 cutoff
for associated .dts changes.

I never heard of *listed* RTC maintainer during all the review process
on rtc-linux list (v0 sent in october); I dug the list archives and when
this previously happened, someone else (e.g. Andrew Morton) was kind
enough to handle the patches:

  http://www.spinics.net/lists/arm-kernel/msg292187.html

I wonder if someone (Andrew? Stephen? Jason?) would be kind enough to
take care of the v6 I just sent [1].

It has been:

  Reviewed-by: Guenter Roeck <linux@roeck-us.net>
  Reviewed-by: Mark Brown <brownie@linaro.org>

Cheers,

a+

[1]: http://patchwork.ozlabs.org/patch/303616/
