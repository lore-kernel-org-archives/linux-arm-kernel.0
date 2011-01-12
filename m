From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 13 Jan 2011 07:34:52 +0900
Subject: [PATCH/RFC 0/3] ARM: S5P: Add a common platform setup code for
	MIPI CSIS/DSIM
In-Reply-To: <4D2D92F9.3000902@gmail.com>
References: <1294153764-25006-1-git-send-email-s.nawrocki@samsung.com>
	<4D2D92F9.3000902@gmail.com>
Message-ID: <01e701cbb2a8$f048bde0$d0da39a0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sylwester Nawrocki wrote:
> 
> On 01/04/2011 04:09 PM, Sylwester Nawrocki wrote:
> > Hello,
> >
> > the following patch series adds the common platform code for configuration
> > of the MIPI CSIS and MIPI DSIM PHYs on S5PV210 and S5PV310 SoCs.
> > The spinlock is used to avoid races while the common PHY control register
> > is accessed from within MIPI DSIM and MIPI CSIS drivers.
> > The common PHY enable bit is cleared only when both CSIS and DSIM devices
> > are not in use.
> >
> >
> > The patch series contains:
> >
> > [PATCH/RFC 1/3] ARM: S5P: Add a platform callback for MIPI CSIS PHY control
> > [PATCH/RFC 2/3] ARM: S5PV310: Add a platform helper for MIPI DSIM/CSIS
> setup
> > [PATCH/RFC 3/3] ARM: S5PV210: Add a platform helper for MIPI DSIM/CSIS
> setup
> >
> 
> Any comments on this one?
> 
Hi,

It's 38 merge window now. So I want to wait until after this merge window.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
