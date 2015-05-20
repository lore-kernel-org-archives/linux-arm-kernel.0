From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 20 May 2015 17:51:01 +0200
Subject: [PATCH 00/14] ARM: berlin: bisect compatible simple-mfd conversion
In-Reply-To: <555CAA36.9020301@gmail.com>
References: <1431735823-28006-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <7681967.oFTclmPvdm@wuerfel> <555CAA36.9020301@gmail.com>
Message-ID: <2978733.6m9o3u51Aq@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 20 May 2015 17:37:26 Sebastian Hesselbarth wrote:
> On 20.05.2015 17:25, Arnd Bergmann wrote:
> > On Saturday 16 May 2015 02:23:29 Sebastian Hesselbarth wrote:
> >>
> >> I am still planing to get this into v4.2 as soon as possible, so if Arnd is
> >> now happy with the dependency of the patches and none of the maintainers is
> >> against it, I'll prepare a PR next week.
> >
> > I haven't see the pull request yet, are you still working on it?
> 
> I was hoping to find some time to actually test bisectability.
> How much time do I have left for getting into v4.2 cycle?

I've reviewed your patches for possible bisection problems now, and
they seem to all be good in this regard. I think it's best if you
send a pull request now. It's not urgent yet, but I'd rather have
more stuff merged earlier than later.

	Arnd
