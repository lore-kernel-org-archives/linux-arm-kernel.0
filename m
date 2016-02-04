From: timur@codeaurora.org (Timur Tabi)
Date: Thu, 4 Feb 2016 07:48:08 -0600
Subject: [PATCH v10 5/5] Watchdog: ARM SBSA Generic Watchdog half timeout
 panic support
In-Reply-To: <56B2DEE4.7060901@roeck-us.net>
References: <1454519923-25230-1-git-send-email-fu.wei@linaro.org>
 <1454519923-25230-6-git-send-email-fu.wei@linaro.org>
 <56B23883.7000501@codeaurora.org>
 <CADyBb7sxPg-QUjTbeHFtYkctKc_g7D8O=+jqbXN+DCCoCEnFqA@mail.gmail.com>
 <56B23E99.1030604@codeaurora.org>
 <CADyBb7s4opxfPFuX=1-qEE6uhsaMXgofAJPbHUQHrng2AUwqNA@mail.gmail.com>
 <56B2423B.1020109@codeaurora.org>
 <CADyBb7uULCn97ea19zH8dB4QX1QA8=AXL94d6gXgFxXM8haBNA@mail.gmail.com>
 <56B24642.8090105@codeaurora.org>
 <CADyBb7s_QeU=pYqN9G+5WMtx-L+=QC6uZR6N6ZWPOixnkHzPjw@mail.gmail.com>
 <56B24AB5.3070001@codeaurora.org>
 <CADyBb7usPpY=YLjecXce63zY5e1tniPLmNsVY=8CJHJsCqBgQw@mail.gmail.com>
 <56B2DEE4.7060901@roeck-us.net>
Message-ID: <56B35698.4020100@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Guenter Roeck wrote:
> Also, if panic is enabled, the timeout needs to be adjusted accordingly
> (to only panic after the entire timeout period has expired, not after
> half of it). We can not panic the system after timeout / 2.

It's a debugging feature, not an actual watchdog timeout panic.  That's 
why it's disabled by default.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
