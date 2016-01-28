From: johannes@sipsolutions.net (Johannes Berg)
Date: Thu, 28 Jan 2016 10:37:09 +0100
Subject: MTK mt8173-evb: mainline unstable, and big-endian boot failures
In-Reply-To: <CAF-23O2y7qRB=ZoU8cn2gcX7rjFdXh+rdLXSjF1nnym79Mknug@mail.gmail.com>
 (sfid-20160128_103122_810896_2EF40B14)
References: <CAOi56cVDbkAJEDWy3+DV63a=UuD7nqpUu8X7e-OjtWM-4dj_-w@mail.gmail.com>
 <CAF-23O2y7qRB=ZoU8cn2gcX7rjFdXh+rdLXSjF1nnym79Mknug@mail.gmail.com>
 (sfid-20160128_103122_810896_2EF40B14)
Message-ID: <1453973829.2217.0.camel@sipsolutions.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2016-01-28 at 17:31 +0800, Koan-Sin Tan wrote:
>?
> > I have yet to debug this any further, but still wanted to report it
> > in case anyone else has the time to debug it further.
> bisect showed that the culprit of the big endian problem is a
> "regmap-mmio: Use native endianness for read/write"
> patch [1]. I saw Johannes already proposed to revert it [2].
> 

Mark has real fixes for it instead:
https://git.kernel.org/cgit/linux/kernel/git/broonie/regmap.git/log/?h=fix/mmio

johannes
