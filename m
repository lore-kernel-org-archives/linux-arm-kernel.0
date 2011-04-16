From: jonas.gorski+openwrt@gmail.com (Jonas Gorski)
Date: Sat, 16 Apr 2011 16:13:06 +0200
Subject: Could I (ab)use bus (struct bus_type) for virtual Broadcom bus?
In-Reply-To: <BANLkTinNoX6GBG=6xVC8ZfOO4OyZ_o=sFg@mail.gmail.com>
References: <1302781431.21145.6.camel@dev.znau.edu.ua>
	<BANLkTinvpt5vs+rXd3WN-a2JpGtTV+=Gyg@mail.gmail.com>
	<4DA6E9BD.3090404@hauke-m.de>
	<BANLkTinu+Q367oqQPiUehPcbMs-SBxbwFg@mail.gmail.com>
	<1302786900.21965.52.camel@dev.znau.edu.ua>
	<BANLkTimM8=-pX+Ea8Eyp4XyvP1APbUof9w@mail.gmail.com>
	<1302892585.30441.12.camel@dev.znau.edu.ua>
	<BANLkTi=16i+D8frz3X2f+JDtp4hbJKLL3A@mail.gmail.com>
	<1302896541.30441.33.camel@dev.znau.edu.ua>
	<BANLkTinPVaYC14Y=m5iu7GYodkRb6uTuPw@mail.gmail.com>
	<20110415195642.22440.qmail@stuge.se>
	<BANLkTinNoX6GBG=6xVC8ZfOO4OyZ_o=sFg@mail.gmail.com>
Message-ID: <BANLkTinXUt1aNudnRqEG40vcrtMBCc3Nxg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 April 2011 16:00, Rafa? Mi?ecki <zajec5@gmail.com> wrote:
> Of the other point there is no sense in calling it
> bcm_amba_axi_for_wifi as I believe we can meet other devices than just
> wifi on this architecture.

Current bcm47xx/53xx SoCs from Broadcom also use this architecture for
the system bus (like the older ones used SSB), and they usually have
ethernet macs, memory controllers, mips cores on it (and, as far as I
can see, also always a 802.11 core).


Jonas
