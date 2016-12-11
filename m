From: afzal.mohd.ma@gmail.com (Afzal Mohammed)
Date: Sun, 11 Dec 2016 12:03:52 +0530
Subject: [RFC v3 PATCH 00/25] Allow NOMMU for MULTIPLATFORM
In-Reply-To: <2683998.OKe6qmCH0L@wuerfel>
References: <1480691143-19845-1-git-send-email-vladimir.murzin@arm.com>
 <20161210181639.GA5660@afzalpc> <2683998.OKe6qmCH0L@wuerfel>
Message-ID: <20161211063352.GA3035@afzalpc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Dec 10, 2016 at 08:19:19PM +0100, Arnd Bergmann wrote:
> On Saturday, December 10, 2016 11:46:39 PM CET Afzal Mohammed wrote:

> > Seems no !MMU A-class suitable toolchains are available, the existing
> > !MMU toolchains available are for either M or R class. Looks like
> > FDPIC one's also are so (cc'ing Maxime & Mickeal in case they have
> > some input here).
> > 
> > And compiling a suitable compiler failed.
> > 
> > Let know if any signposts to travel the remaining distance.

> What's wrong with the R class toolchain?

Yes, hoping that R class toochain for Linux would help here. After a
sleep, the same thing came to my mind.

The search for R class toolchains turned up baremetal ones only
(including Linaro's), but seems there are people using R class with
Linux, so the journey now is to get/create R class Linux toolchain.

Regards
afzal
