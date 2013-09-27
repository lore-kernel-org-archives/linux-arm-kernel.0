From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 27 Sep 2013 15:52:21 -0300
Subject: device tree binding documentation outdated
In-Reply-To: <20130927183101.GE12758@n2100.arm.linux.org.uk>
References: <20130926195158.GS12758@n2100.arm.linux.org.uk>
 <CAOMZO5ANsZGcpvmtBE7d0q0E6+f0bE_U8CBF7G2v3xtqoLbqcA@mail.gmail.com>
 <20130926205906.GT12758@n2100.arm.linux.org.uk>
 <CAHCPf3u9KyoJiAPv6oc_ZdVBqgix41__RAGRXh8z+d5bXO8fQw@mail.gmail.com>
 <20130926232907.GV12758@n2100.arm.linux.org.uk>
 <20130927131554.GB31178@titan.lakedaemon.net>
 <20130927170552.GC12758@n2100.arm.linux.org.uk>
 <20130927183101.GE12758@n2100.arm.linux.org.uk>
Message-ID: <CAOMZO5Csr-vgsKHahnTcMKu1DfgSToYnoVncAfhYFJid-bwviQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 27, 2013 at 3:31 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Sep 27, 2013 at 06:05:52PM +0100, Russell King - ARM Linux wrote:

> An interesting data point.  Connect it to a 100mbit switch and it works.
> gigabit and it behaves as above.
>
> So, the question is: does anyone have gigabit networking working on imx6
> with recent DT based kernels?

Yes, we have Gigabit ethernet working on mx6sabrelite, wandboard,
sabresd boards.

Does the 3.0.35 kernel work with gigabit on cubox-i? Could this issue
be related to the ar8035 phy fixup code?
