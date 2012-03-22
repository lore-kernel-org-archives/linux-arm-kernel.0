From: viresh.linux@gmail.com (viresh kumar)
Date: Thu, 22 Mar 2012 06:15:45 +0530
Subject: [PATCH] ARM: SPEAr600: Add device-tree support to SPEAr600 boards
In-Reply-To: <201203211826.38993.arnd@arndb.de>
References: <1331650032-15274-1-git-send-email-sr@denx.de>
 <CAOh2x==J4qkp29w+v=GWORBua-DE3yb0MRGOtBLyELxbGZwcuA@mail.gmail.com>
 <201203211404.35847.arnd@arndb.de>
 <201203211826.38993.arnd@arndb.de>
Message-ID: <CAOh2x=nZUobbRJo7kdAwmEG+s51BabxPwUVz=S3oNJyTpuRpCQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 21, 2012 at 11:56 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> I just noticed that you have git trees on http://git.stlinux.com/,
> which I would personally prefer you to use actually. git.kernel.org
> is most useful for people that don't have their own git servers.

Ah, that's even better for me too. I don't really have to manage
two trees.

Just to understand the flow, how does this work now?
There can be two sources of patches:
- From ST internal developers
- From external developers

Should i apply them all to my tree and then send you a pull request?
Or you automatically pull everyday from some specific branch?

Sorry i am new to this. :(

--
viresh
