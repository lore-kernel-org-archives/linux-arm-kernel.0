From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sun, 18 Aug 2013 18:34:21 +0200
Subject: [RFC v1 0/5] ARM: Initial support for Marvell Armada 1500
In-Reply-To: <1376682098-10580-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1376682098-10580-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20130818183421.724eb404@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Sebastian Hesselbarth,

On Fri, 16 Aug 2013 21:41:33 +0200, Sebastian Hesselbarth wrote:
> This is a RFC adding initial support for the Marvell Armada 1500
> (88DE3100) found on various consumer devices (Chromecast, GoogleTV).

Nice!

> Actually, it is a two-fold RFC also raising discussions on mach-mvebu
> cleanup roadmap to allow other SoCs to hop into it. While mach-mvebu
> originally was created to add support for Armada 370/XP and merge
> existing Marvell Orion familiy into it, I am not so sure about
> Armada 1500 fits that well (the mbus has gone!).

Technically speaking, the Armada 1500 is not designed by the EBU
division of Marvell (that does the Orion, Kirkwood, Armada 370/XP SOCs),
so having it under mach-mvebu may sound a little bit strange. However,
I don't yet have a clear vision of how much different the platform code
will be, especially since the platform code tends to get smaller and
smaller due to the move of lots of code to drivers/.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
