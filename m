From: robdclark@gmail.com (Rob Clark)
Date: Mon, 1 Jul 2013 19:33:14 -0400
Subject: [PATCH RFC 1/3] DRM: Armada: Add Armada DRM driver
In-Reply-To: <CAPM=9tzaCyuut=fkGCDCqi1cFirPF-G4GRWYdRDGUfRCc-C7-w@mail.gmail.com>
References: <20130629225210.GF3353@n2100.arm.linux.org.uk>
 <E1Ut41C-0000wl-Ff@rmk-PC.arm.linux.org.uk>
 <20130630115941.GG18285@phenom.ffwll.local>
 <20130630125238.GH3353@n2100.arm.linux.org.uk>
 <CAPM=9tydcpP2-A6fnnHB873Nekj4HnxjraZ3TtRG3UF-Bqa6OQ@mail.gmail.com>
 <51D14333.40307@gmail.com>
 <20130701094258.GT18285@phenom.ffwll.local>
 <51D15F13.7040408@gmail.com>
 <CAPM=9tzaCyuut=fkGCDCqi1cFirPF-G4GRWYdRDGUfRCc-C7-w@mail.gmail.com>
Message-ID: <CAF6AEGtMa+hOAgGO47H8Lkwqs9OdX8m-H0i6YCOhu5upbnPV3w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 1, 2013 at 5:26 PM, Dave Airlie <airlied@gmail.com> wrote:
>> Of course, I share the idea of true, full-blown of_drm_something
>> helpers. But the DT patch, is not an improvement but a real fix as in
>> "make DRM not break on some platforms". From that on, I can start
>> digging into DRM API and improve DT support here and there.
>>
>> So for the three patches I mentioned above, they are all minor
>> improvements of the API. Minor, because I cannot ever sent _the_ single
>> perfect patch just because I don't know the API well enough, yet.
>>
>> Just based on my personal experience: TDA998x driver got merged the way it
>> is _although_ I addressed some concerns - the fixes are not merged
>> _although_ I provided experimental results. This is of course
>> disappointing for me, but I am sure it will work out soon and I will
>> get back to happily send improvements for the platforms I can test on.
>
> To be honest I've no idea what those tda998x patches could fix or
> break, so they go on my no ideas list and I hope if they get reposted
> someone will tell me what they do.

IIRC, a few of those patches were breaking things on tilcdc, which
someone needs to get to the bottom of..  and for that I'm relying a
bit on Darren as he is the one with both hw to test with tilcdc plus
an hdmi tester.  And I think understands the issue better than I do at
this point.

> I could probably be more motivated towards poking other people to
> review stuff, but I mostly hope in vain that the ARM people will cross
> review things for other ARM chips, I had a bit of that happening for a
> while at the start, but it seems to have died off. Now I'm mostly
> relying on Rob to have some clue what I'm merging is sane.
>
> My current priority for merging stuff is:
> core patches that affect all platforms,
> core patches that affect x86
> drivers that I maintain by default
> core patches that affect ARM
> misc ARM drivers that fall through cracks.
>
> Maybe I can persuade Rob to become a sub maintainer for all of the SoC
> drivers but I suspect he'd try and hurt me in real life.

/me runs :-P

well, anyways, I do at least try to review arm patches.  Things
sometimes do fall on the floor when I'm busy in other areas.

BR,
-R

> I'll take another look at the tda patches but I may still have no idea
> what they are doing.
>
> Dave.
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/dri-devel
