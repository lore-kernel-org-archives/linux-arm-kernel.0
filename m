From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Sat, 23 Nov 2013 01:23:41 +0400
Subject: [PATCH 0/9] ARM: sa1100: Rework IRQ handling
In-Reply-To: <20131122195154.GD16735@n2100.arm.linux.org.uk>
References: <1384505280-25389-1-git-send-email-dbaryshkov@gmail.com>
 <CACRpkdZU3_EqhBjV68+okJwh7QONuxWVjKkrUO4PkwJhKrP+mQ@mail.gmail.com>
 <528B811A.1030501@gmail.com>
 <CACRpkdbgn22xDX4nJZSDSE9-h+u1j5DQt=8arO7oS-UCBdBMUQ@mail.gmail.com>
 <20131120002007.GR16735@n2100.arm.linux.org.uk>
 <CALT56yP-LsO_8qgpa3R6JQSWW2pGkNWBUtab8L2hQnC5UdoKvQ@mail.gmail.com>
 <20131122175814.GC16735@n2100.arm.linux.org.uk>
 <CALT56yNPmjje=8w2-3xo-80nVum2bhedMio8kp+gvizeGxQ5Kw@mail.gmail.com>
 <20131122195154.GD16735@n2100.arm.linux.org.uk>
Message-ID: <CALT56yO9J6OYDUDo4mrdf+QbV7V4H8cde-FZuo+9u_T_=pdH4w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 22, 2013 at 11:51 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Nov 22, 2013 at 11:12:05PM +0400, Dmitry Eremin-Solenikov wrote:
>> For sa1100 there are only 2.5 platforms which use gpiolib - collie and h3xxx.
>> (The half is for simpad, which registers gpio chip from platform code, but
>> doesn't use it otherwise -- in platform code, of course).
>
> Oh well, I guess it doesn't matter then, if we're only breaking 2.5
> platforms.
>
> No.  It does matter.  This needs fixing.

Collie was updated during this serie. Simpad was not broken.
And h3xxx was updated in a separate patchset (I would like to
hear yours and Linuses opinion about it anyway).

-- 
With best wishes
Dmitry
