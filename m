From: rric@kernel.org (Robert Richter)
Date: Fri, 5 Sep 2014 08:55:19 +0200
Subject: [PATCH] arm64, dts: Add dtbs_install make target
In-Reply-To: <20140829134942.GP4703@rric.localhost>
References: <1406732794-20920-1-git-send-email-rric@kernel.org>
 <1406732794-20920-3-git-send-email-rric@kernel.org>
 <CAOesGMh9KkdKB_ytJ7CCbkPW7dHTX91NdfDMsMNfbmOBVOJ8PQ@mail.gmail.com>
 <20140828161556.GN4703@rric.localhost>
 <20140828162549.GP14650@leverpostej>
 <CAOesGMjtjcgUNV8WLp6_Zbok-0zq5afg_KS8QJYp=kDVabrQvg@mail.gmail.com>
 <20140828181429.GO4703@rric.localhost>
 <CAOesGMh3TEKZkyPjopfSm07C2ydw5=2VrzY0xQ=9jkhoA-Z_kQ@mail.gmail.com>
 <20140829121023.GW13038@rric.localhost>
 <20140829134942.GP4703@rric.localhost>
Message-ID: <20140905065519.GQ4703@rric.localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof,

On 29.08.14 15:49:42, Robert Richter wrote:
> On 29.08.14 14:10:23, Robert Richter wrote:
> > On 28.08.14 16:01:08, Olof Johansson wrote:
> > > Thinking about it a bit more, the even more obvious solution that I
> > > for some reason didn't think of at the time, is to have the
> > > dtbs_install target create the appropriate subdirectories on the
> > > install side, so that the structure is preserved.
> > > 
> > > That comes a bit closer to how modules are handled as well.
> > 
> > Yes, dtbs_install target would be useful.
> > 
> > Will come with a solution for this too.
> 
> below is a patch that adds the dtbs_install target to arm64. Taken
> from arm where this was already implemented.

please note that I sent a separate patch set with a complete
implementation of this with the title:

 [PATCH 0/6] dts, kbuild: Implement support for dtb vendor subdirs

this patch is included there too.

-Robert
