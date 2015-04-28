From: pebolle@tiscali.nl (Paul Bolle)
Date: Tue, 28 Apr 2015 21:57:25 +0200
Subject: [PATCH] arch/arm/mm/proc-arm925.S: remove dead #ifdef block
In-Reply-To: <CAD3Xx4KDNTb6EFfeSOW_-cL0owvjAkNDR8+A3StHHZW6LNgYkA@mail.gmail.com>
References: <1430239529-15726-1-git-send-email-valentinrothberg@gmail.com>
 <1430249097.2411.74.camel@x220>
 <CAD3Xx4KDNTb6EFfeSOW_-cL0owvjAkNDR8+A3StHHZW6LNgYkA@mail.gmail.com>
Message-ID: <1430251045.2411.88.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2015-04-28 at 21:36 +0200, Valentin Rothberg wrote:
> Thanks!  I just wanted to point out that this code hasn't been touched
> since I was at high school : )

(Yes, fine, do rub it in.)

Sure, for all practical purposes, v2.6.12-rc2 means: very, very long
ago. But I would be applaud if someone managed to outdo my reference to
v1.3.82 in commit e5a7286b5f1b ("x86, boot: Remove ancient,
unconditionally #ifdef'd out dead code").

> Do you link the repositories or do you have a separate history repo?

I started with https://archive.org/details/git-history-of-linux . Its
main drawback is that you have to the add tags for ancient releases
yourself. And that turned out to be quite time consuming.

Thanks,


Paul Bolle
