From: vannigenua@gmail.com (Vanni Genua)
Date: Fri, 7 Sep 2012 07:37:43 +0000
Subject: Perf doesn't support coresight or it doesn't read the PMU registers
 on Pandaboard Rev.A2
In-Reply-To: <CAO8ONPyN_c9Tek1ym3jNx0K4B7SvEghRCON_ZP-dMeFP_jcirA@mail.gmail.com>
References: <CAO8ONPyN_c9Tek1ym3jNx0K4B7SvEghRCON_ZP-dMeFP_jcirA@mail.gmail.com>
Message-ID: <CAO8ONPwRiWi6JOHXVVK7wx9UOZ9Bsv-L7yV-w2hcCKpjXfLhOw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi there,
I'm testing a Pandaboard (OMAP4430, ARMv7) with Linux kernel 3.0.27-rt46
installed on it.
The following instruction is not working due to unsupported cache-misses
event.
#perf stat -e cache-misses echo "Hello"
Performance counter stats for 'echo "Hello"
':


   <not supported>
cache-misses


       0.007507575 seconds time elapsed

How to solve this problem?
Is there any patch for Perf o Linux kernel?
Thank you.
Best regards.
Vanni Genua
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120907/39e2a12d/attachment.html>
