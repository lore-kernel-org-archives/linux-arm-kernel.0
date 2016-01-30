From: narmstrong@baylibre.com (Neil Armstrong)
Date: Sat, 30 Jan 2016 15:51:06 +0100
Subject: [PATCH 4/4] pwm: omap-dmtimer: add dev_dbg() message for
 effective period and duty cycle
In-Reply-To: <1454128014-22866-5-git-send-email-drivshin.allworx@gmail.com>
References: <1454128014-22866-1-git-send-email-drivshin.allworx@gmail.com>
 <1454128014-22866-5-git-send-email-drivshin.allworx@gmail.com>
Message-ID: <CAA3gFWvSsctXtds6_SEtYY1yUdWJDR1XjznGS6qjdrGW5Dbw=A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-01-30 5:26 GMT+01:00 David Rivshin (Allworx) <drivshin.allworx@gmail.com>:
> From: David Rivshin <drivshin@allworx.com>
>
> After going through the math and constraints checking to compute load and
> match values, it is helpful to know what the resultant period and duty
> cycle are.
>
> Signed-off-by: David Rivshin <drivshin@allworx.com>
> ---
>
> I found this helpful while testing the other changes, so I included it in
> case it may be of use to someone in the future. I would have no issues with
> dropping this if it's not considered worthwhile.

It's useful, but converting it as a sysfs attribute would be great !


Neil
