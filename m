From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 19 May 2015 17:14:19 +0100
Subject: [PATCH 1/2] ARM: imx: enable smp for i.MX7D
In-Reply-To: <CAHrpEqSGQ4G-nkCporLee5fw0fFtB5+m3dJK2dGdYDd2R+rKrw@mail.gmail.com>
References: <1431378955-991-1-git-send-email-Frank.Li@freescale.com>
 <20150519025758.GK1071@dragon>
 <CAHrpEqTwwb0P1wE+AOYVPgPz8=tBbEKn92amWaoN63GPOJxRgw@mail.gmail.com>
 <20150519150852.GI2067@n2100.arm.linux.org.uk>
 <CAHrpEqSGQ4G-nkCporLee5fw0fFtB5+m3dJK2dGdYDd2R+rKrw@mail.gmail.com>
Message-ID: <20150519161419.GJ2067@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 19, 2015 at 10:52:23AM -0500, Zhi Li wrote:
> On Tue, May 19, 2015 at 10:08 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > I think that should
> > become v7_invalidate_l1, which would then elimiante all the platforms
> > which are doing this local hack.
> 
> I think this is good.
> What can I do for this patch?

Just wait for it to filter through the mailing list - it's on its way. :)

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
