From: p.fedin@samsung.com (Pavel Fedin)
Date: Tue, 06 Oct 2015 13:16:13 +0300
Subject: [PATCH 0/2] ARM: EXYNOS: Allow to use architected timer
In-Reply-To: <187701d1001f$284b1350$78e139f0$@kernel.org>
References: <cover.1444119342.git.p.fedin@samsung.com>
 <6613638.q5qyQZxXy7@wuerfel> <00d801d10014$e6d994a0$b48cbde0$@samsung.com>
 <187701d1001f$284b1350$78e139f0$@kernel.org>
Message-ID: <010601d10020$084de090$18e9a1b0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Hello!

> No, because the MCT should be used by default _always_ and it is depending on hardware
> scheme...

 You just said: "by default". My proposal follows this. What's wrong then?
 Or don't you just want users to be able to use KVM on Exynos?

> >  So, i think that having an option to use CP15 would be a good solution. It is known to work,
> and i
> > use this configuration here on SMDK5410 without any problems.
> >
> Actually Exynos5410 has been designed differently so it is safe only on smdk5410 not others...

 Odroid-XU users also report it working. So, i guess, it's Exynos-5410's property. Well, does not
matter after all...

Kind regards,
Pavel Fedin
Expert Engineer
Samsung Electronics Research center Russia
