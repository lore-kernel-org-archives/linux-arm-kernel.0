From: swetland@google.com (Brian Swetland)
Date: Sun, 6 Dec 2009 15:27:38 -0800
Subject: HTC Dream: dream is better name for this machine
In-Reply-To: <20091206205041.GA12555@elf.ucw.cz>
References: <20091206205041.GA12555@elf.ucw.cz>
Message-ID: <a55d774e0912061527t5b09b510g1fc458b53a423c04@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 6, 2009 at 12:50 PM, Pavel Machek <pavel@ucw.cz> wrote:
>
> While few people may know HTC Dream by its codename, it is better to
> use name of released hardware in the sources.

I still think that it'd be less pain for everyone to leave it as
trout.  If you go by sales volume, the most known released hardware
name is "Tmobile G1", some people know it as ADP1, and I believe it
has sold under a few other names in other markets, but the software
has, since day one, been trout and changing that just makes it harder
to merge other existing changes where we'd have to deal with renames
as well.  The bootloader identifies it as "trout", and the userspace
software stack's hardware-specific bits refer to trout.

If it really drives everyone crazy, we could do a big rename once it's
all in and working, but right now I just don't see the benefit.

Brian
