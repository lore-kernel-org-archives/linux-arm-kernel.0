From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 31 Oct 2016 16:19:19 +0000
Subject: [PATCH] ARM: mm: add ARM_L1_CACHE_SHIFT_7 for UniPhier outer cache
In-Reply-To: <CAK7LNAQfZ86_V6ZC5nnCB7Y4EvOPtFBUDM+Kfm9UNyE9h6MA4Q@mail.gmail.com>
References: <1476880777-5068-1-git-send-email-yamada.masahiro@socionext.com>
 <CAK7LNAQfZ86_V6ZC5nnCB7Y4EvOPtFBUDM+Kfm9UNyE9h6MA4Q@mail.gmail.com>
Message-ID: <20161031161919.GJ1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 30, 2016 at 12:31:04AM +0900, Masahiro Yamada wrote:
> Hi.
> 
> If there is no objection to this patch,
> I will put it into Russell's patch tracker.

I don't think I have any objection, it's following the same pattern
that we have for 64-byte cache lines, and this is about the only way
to deal with it.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
