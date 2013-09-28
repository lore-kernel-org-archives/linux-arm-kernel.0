From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 28 Sep 2013 00:28:46 -0300
Subject: device tree binding documentation outdated
In-Reply-To: <CAHCPf3vxGAzTnY360KC7Yt-DB1FB14Sv_Cn7DBTH6HGZ6y=stg@mail.gmail.com>
References: <20130926195158.GS12758@n2100.arm.linux.org.uk>
 <CAOMZO5ANsZGcpvmtBE7d0q0E6+f0bE_U8CBF7G2v3xtqoLbqcA@mail.gmail.com>
 <20130926205906.GT12758@n2100.arm.linux.org.uk>
 <CAOMZO5Dj7o3qBH2hzPFWjepgpt5XR5qKmQorKS6jH_7=gnY5cg@mail.gmail.com>
 <20130927121357.GY12758@n2100.arm.linux.org.uk>
 <20130927132601.GL25146@S2101-09.ap.freescale.net>
 <20130927151900.GA12758@n2100.arm.linux.org.uk>
 <CAHCPf3t8=mJn-RCz3C1cY6zqsH9ds8UANKpKx9ZpwPM6WjJt3g@mail.gmail.com>
 <20130927174916.GD12758@n2100.arm.linux.org.uk>
 <CAHCPf3sC7bY=p4vpBQFpRUmyPspT_PVjx0rH9cm1ov=SqkO+Vg@mail.gmail.com>
 <20130927190546.GG12758@n2100.arm.linux.org.uk>
 <CAHCPf3vxGAzTnY360KC7Yt-DB1FB14Sv_Cn7DBTH6HGZ6y=stg@mail.gmail.com>
Message-ID: <CAOMZO5Ap39b_UJvDjy7UGWV8iL6nLYg0-9xSd5zaR1UEbzkXYw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Matt,

On Fri, Sep 27, 2013 at 4:41 PM, Matt Sealey <neko@bakuhatsu.net> wrote:
> Subtle difference which I know I just faceplanted on in my previous
> mail.. Same concept though... but if you have a DualLite then you
> don't HAVE gigabit ethernet... a 125MHz clock is ridiculous, and Fabio
> gave you the wrong manual.

What you say here is not correct.

quad and dual: have Gigabit ethernet
dual-lite and solo: have Gigabit ethernet
solo-lite: don't have Gigabit ethernet

Anyway, good news that Russell managed to get ethernet running on cubox-i.

I will probably get access to a cubox-i next week :-)
