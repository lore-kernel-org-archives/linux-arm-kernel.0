From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 12 Aug 2016 14:52:12 +0100
Subject: [PATCH] arm: add an option for erratum 657417
In-Reply-To: <CAKv+Gu_vmpg5ks4hPRYhJGEDBxy4oQW6wDGu1fjKSzEwW7y2uw@mail.gmail.com>
References: <1470989957-23671-1-git-send-email-npiggin@gmail.com>
 <20160812123314.GX1041@n2100.armlinux.org.uk>
 <20160812231503.3e2e059b@roar.ozlabs.ibm.com>
 <CAKv+Gu-Ek0NEPP9f2Jp+3ZxwRAP8rqPwwwRa56b2Bz4i=7h=Jw@mail.gmail.com>
 <CAKv+Gu_vmpg5ks4hPRYhJGEDBxy4oQW6wDGu1fjKSzEwW7y2uw@mail.gmail.com>
Message-ID: <20160812135212.GZ1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 12, 2016 at 03:50:17PM +0200, Ard Biesheuvel wrote:
> $ objdump -dr vmlinux |grep -A1 -E \\sb\.w |less
> 
> I get numerous instances of b.w that are not covered by any
> relocations, so i assume that will be the case for modules as well.

Not surprising.  vmlinux is fully linked.  There's no relocations.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
