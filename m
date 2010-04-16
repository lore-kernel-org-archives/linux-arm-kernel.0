From: eric.y.miao@gmail.com (Eric Miao)
Date: Fri, 16 Apr 2010 14:25:16 +0800
Subject: 2.6.34-rc3 vs zaurus spitz: mistery solved
In-Reply-To: <20100415180314.GC1443@ucw.cz>
References: <20100415180314.GC1443@ucw.cz>
Message-ID: <x2qf17812d71004152325v26785671r23aafd9444614590@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 16, 2010 at 2:03 AM, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
> For some reason, spitz will hang very early in boot with SLUB. With
> SLOB, it boots fine.
>

Weird, just wondering for what specific reason. Pavel, could you possibly
paste the failure log if possible?

> SLUB worked fine in 2.6.33 and SLOB is hidden under CONFIG_EMBEDDED,
> so it took a while to figure out.
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?Pavel
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
>
