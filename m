From: khilman@ti.com (Kevin Hilman)
Date: Thu, 10 May 2012 15:13:36 -0700
Subject: [PATCH 0/8] gpio/omap: remaining cleanups and fix
In-Reply-To: <CAMrsUdJg6bftZdtGM3Pfz7FO=69AfgCc86cDgGRxHW2gXR+0BA@mail.gmail.com>
 (Govindraj Raja's message of "Thu, 10 May 2012 12:08:10 +0530")
References: <1335536018-16004-1-git-send-email-tarun.kanti@ti.com>
 <CAMrsUdJg6bftZdtGM3Pfz7FO=69AfgCc86cDgGRxHW2gXR+0BA@mail.gmail.com>
Message-ID: <87y5ozu1kf.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Govindraj,

"Raja, Govindraj" <govindraj.raja@ti.com> writes:

[...]

> I tested this series from your tree on Beagle-XM retention, offmode,
> suspend to mem and resume with and and without enabling offmode
> from sysfs was checked and found retention count and off mode
> count was getting incremented.
>
> Also ran few test cases available from here[1] to request and release gpio,
> test cases passed.
>
> Feel Free to add:
>
> Tested-by: Govindraj.R <govindraj.raja@ti.com>

Awesome!

Many thanks for the testing.  It *greatly* helps when maintainers can
see more testing by folks other than the author.

Thank you!

Kevin
