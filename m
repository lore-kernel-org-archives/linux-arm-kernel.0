From: olof@lixom.net (Olof Johansson)
Date: Thu, 28 Feb 2013 17:47:13 -0800
Subject: [PATCH] ARM: dts: remove generated .dtb files on clean
In-Reply-To: <CAGo_u6qZwgGOugh3_F2pFvwM8ZAxU=Rsy7B2Lj6CjO+VG7GwXA@mail.gmail.com>
References: <1358890049-26981-1-git-send-email-nm@ti.com>
 <5108BDDD.60307@ti.com>
 <CAGo_u6qZwgGOugh3_F2pFvwM8ZAxU=Rsy7B2Lj6CjO+VG7GwXA@mail.gmail.com>
Message-ID: <CAOesGMgZ4VPnkn7ZuNPYeA9fv=ACwXy8-wr6L3ttVfPkRjaZnw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 28, 2013 at 5:35 PM, Nishanth Menon <nm@ti.com> wrote:
> On Wed, Jan 30, 2013 at 12:29 AM, Santosh Shilimkar
> <santosh.shilimkar@ti.com> wrote:
>> Looping RMK, Arnd
> Gentle query if we are still interested in this:
> https://patchwork.kernel.org/patch/2020831/
>
> Looks like linux master still wont delete the dtbs on make clean etc..
> I think leaving the stale dtbs
> around could have it's set of user errors.

Applied to arm-soc fixes for 3.9.


-Olof
