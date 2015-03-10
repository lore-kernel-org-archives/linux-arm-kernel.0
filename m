From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 10 Mar 2015 22:13:43 +0100
Subject: [PATCH] ARM: at91: force CPU selection
In-Reply-To: <20150310200209.GE4124@norris-Latitude-E6410>
References: <1425970798-14015-1-git-send-email-computersforpeace@gmail.com>
 <2216832.iXiqHye8YX@wuerfel>
 <20150310200209.GE4124@norris-Latitude-E6410>
Message-ID: <20150310211343.GI9188@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/03/2015 at 13:02:09 -0700, Brian Norris wrote :
> On Tue, Mar 10, 2015 at 10:02:15AM +0100, Arnd Bergmann wrote:
> > I actually added a bunch of these in other places, but have stopped
> > doing so because Russell didn't like them, and I tend to follow
> > his argument now that it's actually pretty confusing.
> 
> I'm not a big fan of my patch, but it did at least solve the problem.
> Thanks for the info, and I'm happy to drop my patch. At least I've fixed
> my compile-test setups to avoid bad combinations, now.
> 
> To be clear, multiplatform support is in progress, but not merged yet,
> right?
> 

I can point you to the patch series if you want. Hopefully, this will be
merged for 4.1


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
