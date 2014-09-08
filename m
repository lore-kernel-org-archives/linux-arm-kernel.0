From: will.deacon@arm.com (Will Deacon)
Date: Mon, 8 Sep 2014 17:07:58 +0100
Subject: Unable to boot mainline on snow chromebook since 3.15
In-Reply-To: <CAD=FV=U_ZwgqBWN_bLfi97rjMLmDoQBk17gtQS1_ekxJKWJO6w@mail.gmail.com>
References: <20140905115704.GO13515@arm.com> <20140905122232.GP13515@arm.com>
 <CAD=FV=VfioJf9VYoSYL0QBk-bN93-Ecx3=0n9hb5Q4rcx43-_g@mail.gmail.com>
 <540C202E.2060009@collabora.co.uk> <540C7F5B.6070307@gmail.com>
 <CAD=FV=UYDDhL02CrhPUAHPncepwAF2-BgTmXOamy-Mdz80S-vw@mail.gmail.com>
 <540D481F.8030500@collabora.co.uk>
 <CAD=FV=U_ZwgqBWN_bLfi97rjMLmDoQBk17gtQS1_ekxJKWJO6w@mail.gmail.com>
Message-ID: <20140908160758.GS26030@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 08, 2014 at 04:55:31PM +0100, Doug Anderson wrote:
> So "simple-framebuffer" is added to the device tree here:
> 
> https://chromium-review.googlesource.com/#/c/49358/2/board/samsung/smdk5250/smdk5250.c
> 
> That's one of the two patches to build your own U-Boot for enabling
> simplefb.  You'll notice that's not a super official thing.  It's a
> "DO NOT SUBMIT" patch sitting in a gerrit code review server, so I
> wouldn't exactly call it a stable ABI that we can't break.  It's not
> something shipping in real products and it's not even landed in a git
> tree (I suppose maybe someone somewhere landed it, but...).

I just took the uboot image linked to from the chromium.org page here:

  http://www.chromium.org/chromium-os/u-boot-porting-guide/using-nv-u-boot-on-the-samsung-arm-chromebook#TOC-Getting-nv-U-Boot

Will
