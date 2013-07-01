From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 02 Jul 2013 00:07:41 +0200
Subject: [PATCH RFC 1/3] DRM: Armada: Add Armada DRM driver
In-Reply-To: <CAF6AEGuJZeFBKgnTa8NM82jsfyx1wuyRcVnb9g2fqrZ+1LSuKw@mail.gmail.com>
References: <20130629225210.GF3353@n2100.arm.linux.org.uk>
 <E1Ut41C-0000wl-Ff@rmk-PC.arm.linux.org.uk>
 <20130630115941.GG18285@phenom.ffwll.local>
 <20130630125238.GH3353@n2100.arm.linux.org.uk>
 <CAPM=9tydcpP2-A6fnnHB873Nekj4HnxjraZ3TtRG3UF-Bqa6OQ@mail.gmail.com>
 <51D14333.40307@gmail.com>
 <CAF6AEGuJZeFBKgnTa8NM82jsfyx1wuyRcVnb9g2fqrZ+1LSuKw@mail.gmail.com>
Message-ID: <51D1FDAD.9090109@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/01/2013 11:55 PM, Rob Clark wrote:
> On Mon, Jul 1, 2013 at 4:52 AM, Sebastian Hesselbarth
> <sebastian.hesselbarth@gmail.com>  wrote:
>> - TDA998x irq handling - ignored
>> - TDA998x sync fix - ignored
>
> At least the sync fix, looks like I missed it (it probably is a good
> idea to CC me if you want me to look at it).  Looks like there was
> some follow-up discussion on both patches, unless I missed seeing a
> newer version of those patches.

Yeah, I will update the patch for current mainline linux as it was
based on some of Russell's RFC patches.

> Sometimes if you think a patch has been ignored/forgotten, it doesn't
> hurt to ping on mailing list or #dri-devel..  a lot of us are working
> not just on kernel (the relatively small part in the whole linux
> graphics stack), but also mesa and/or x11.  Some times things end up
> several pages down in the mail folder.  It's not because we are all
> sitting on a beach drinking margaritas, or because we don't like you.
> It is just because we are busy and missed it.
>
> Last few months I've been pretty buried in r/e + gallium driver for
> new gpu, so I wasn't always checking dri-devel list every day.  At
> least now I am in drm-driver mode again ;-)

It is ok, I don't blame anyone here. Darren wants to test it on tilcdc.
I also found a datasheet for TDA9983b which is kind of compatible but
has more information about register layout in it. IIRC digikey also has
it.

>> - Fix drm I2C slave encoder probing
>>
> If you have a better idea about how to make the slave encoder probing
> better (and/or more generic to support stuff other than i2c), please
> send RFC patch.  (And if you already did this, please send updated
> version, see previous point about sometimes missing patches.)

Also, will send an updated fix.

Sebastian
