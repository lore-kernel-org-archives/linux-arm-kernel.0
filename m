From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 01 Jul 2013 10:52:03 +0200
Subject: [PATCH RFC 1/3] DRM: Armada: Add Armada DRM driver
In-Reply-To: <CAPM=9tydcpP2-A6fnnHB873Nekj4HnxjraZ3TtRG3UF-Bqa6OQ@mail.gmail.com>
References: <20130629225210.GF3353@n2100.arm.linux.org.uk>
 <E1Ut41C-0000wl-Ff@rmk-PC.arm.linux.org.uk>
 <20130630115941.GG18285@phenom.ffwll.local>
 <20130630125238.GH3353@n2100.arm.linux.org.uk>
 <CAPM=9tydcpP2-A6fnnHB873Nekj4HnxjraZ3TtRG3UF-Bqa6OQ@mail.gmail.com>
Message-ID: <51D14333.40307@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/01/13 02:01, Dave Airlie wrote:
> how about instead of writing:
> "However, at least I've taken the time to_think_  about what I'm doing
> and realise that there_is_  scope here for the DRM core to improve,
> rather than burying this stuff deep inside my driver like everyone else
> has.  That's no reason to penalise patches from the "good guys" who think"
>
> you go with
> "I noticed this piece of functionality could be refactored, here is a
> patch adding them to
> the core, does anyone think its a good idea?"

Dave,

at least on this point I do share Russell's impression. I've sent
bunch of patches improving TDA998x and DRM+DT:
- TDA998x irq handling - ignored
- TDA998x sync fix - ignored
- Fix drm I2C slave encoder probing

I am aware that this is not an easy job nor one you get much
appreciation for. But, back when TDA998x driver was published,
all my comments were basically answered with "Oh, I know. Maybe
someday somebody will fix it".

I am not being paid for any of this, but have a strong intrinsic
motivation here. But I am loosing interest in sending fixes for
DRM stuff because my (personal) impression is the same Russell
has: Depending on who sends patches, they get merged independent
of how broken they are - others are discussed to death.

Sebastian
