From: airlied@gmail.com (Dave Airlie)
Date: Tue, 2 Jul 2013 07:26:31 +1000
Subject: [PATCH RFC 1/3] DRM: Armada: Add Armada DRM driver
In-Reply-To: <51D15F13.7040408@gmail.com>
References: <20130629225210.GF3353@n2100.arm.linux.org.uk>
 <E1Ut41C-0000wl-Ff@rmk-PC.arm.linux.org.uk>
 <20130630115941.GG18285@phenom.ffwll.local>
 <20130630125238.GH3353@n2100.arm.linux.org.uk>
 <CAPM=9tydcpP2-A6fnnHB873Nekj4HnxjraZ3TtRG3UF-Bqa6OQ@mail.gmail.com>
 <51D14333.40307@gmail.com>
 <20130701094258.GT18285@phenom.ffwll.local>
 <51D15F13.7040408@gmail.com>
Message-ID: <CAPM=9tzaCyuut=fkGCDCqi1cFirPF-G4GRWYdRDGUfRCc-C7-w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Of course, I share the idea of true, full-blown of_drm_something
> helpers. But the DT patch, is not an improvement but a real fix as in
> "make DRM not break on some platforms". From that on, I can start
> digging into DRM API and improve DT support here and there.
>
> So for the three patches I mentioned above, they are all minor
> improvements of the API. Minor, because I cannot ever sent _the_ single
> perfect patch just because I don't know the API well enough, yet.
>
> Just based on my personal experience: TDA998x driver got merged the way it
> is _although_ I addressed some concerns - the fixes are not merged
> _although_ I provided experimental results. This is of course
> disappointing for me, but I am sure it will work out soon and I will
> get back to happily send improvements for the platforms I can test on.

To be honest I've no idea what those tda998x patches could fix or
break, so they go on my no ideas list and I hope if they get reposted
someone will tell me what they do.

I could probably be more motivated towards poking other people to
review stuff, but I mostly hope in vain that the ARM people will cross
review things for other ARM chips, I had a bit of that happening for a
while at the start, but it seems to have died off. Now I'm mostly
relying on Rob to have some clue what I'm merging is sane.

My current priority for merging stuff is:
core patches that affect all platforms,
core patches that affect x86
drivers that I maintain by default
core patches that affect ARM
misc ARM drivers that fall through cracks.

Maybe I can persuade Rob to become a sub maintainer for all of the SoC
drivers but I suspect he'd try and hurt me in real life.

I'll take another look at the tda patches but I may still have no idea
what they are doing.

Dave.
