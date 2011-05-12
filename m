From: saeed.bishara@gmail.com (saeed bishara)
Date: Thu, 12 May 2011 13:40:40 +0300
Subject: [PATCH 13/14] [dove] Remove mpp.[ch]. They are not used.
In-Reply-To: <20110508171918.GC4071@lunn.ch>
References: <1304864141-1121-1-git-send-email-andrew@lunn.ch>
	<1304864141-1121-14-git-send-email-andrew@lunn.ch>
	<BANLkTi=mLaj0wa0PA9uokZ5ekuNbSEPthQ@mail.gmail.com>
	<20110508171918.GC4071@lunn.ch>
Message-ID: <BANLkTikrZuNbxp0uPnARXpoQWoALBo8EnA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 8, 2011 at 8:19 PM, Andrew Lunn <andrew@lunn.ch> wrote:
> On Sun, May 08, 2011 at 05:39:08PM +0300, saeed bishara wrote:
>> On Sun, May 8, 2011 at 5:15 PM, Andrew Lunn <andrew@lunn.ch> wrote:
>> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
>> > ---
>> > ??arch/arm/mach-dove/Makefile | ?? ??2 +-
>> > ??arch/arm/mach-dove/mpp.c ?? ??| ??209 ----------------------------------------
>> > ??arch/arm/mach-dove/mpp.h ?? ??| ??220 -------------------------------------------
>> > ??3 files changed, 1 insertions(+), 430 deletions(-)
>> > ??delete mode 100644 arch/arm/mach-dove/mpp.c
>> > ??delete mode 100644 arch/arm/mach-dove/mpp.h
>> No, it currently not used, by we for sure will use at some point. we
>> are planning to prepare such patches for the next release. so please
>> keep it.
>
> O.K. I can drop this patch.
>
> I don't have a datasheet for the Dove. Do you think it is possible to
> merge the dove mpp setup code with the kirkwood and mv78xx0?
I think that low mpps (0-23) can be configured using this common code.
> ? ? ?Thanks
> ? ? ? ?Andrew
>
