From: jean-michel.hautbois@veo-labs.com (Jean-Michel Hautbois)
Date: Wed, 4 Nov 2015 17:52:33 +0100
Subject: i.MX6: Increasing VPU frequency
Message-ID: <CAH-u=82M1yCmPjBg5qeiC8JiHjM8+WsP+utX_VPKfJwJsu0QFg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi !

I can see in FSL kernel that VPU is configurable to 352M (it defaults
at 264MHz in mainline I think).
In the TRM, it is even specified at 352MHz as a default frequency,
with a maximum of 540MHz.

Would it be possible to allow this clock rating modification if, for
instance, we select a performance governor in cpufreq, or if a coda
encoder is started with 1080p for instance ?
If so, then how is it doable properly ?

Another question is the IPU frequency, but I think it can run only @264MHz...

Thanks,
JM
