From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 29 Oct 2013 18:53:52 +0000
Subject: [PATCH v3] imx-drm: Add mx6 hdmi transmitter support
In-Reply-To: <CAOMZO5DN0KGvUBut0BqyvPTdyByWtZ=uamTpQGeENBzMOfJK3A@mail.gmail.com>
References: <1382992009-19407-1-git-send-email-festevam@gmail.com>
 <20131028211945.GJ16735@n2100.arm.linux.org.uk>
 <CAOMZO5BYXv4whoRrRD7pF5zj9DArEnbqFaZVdLgZgPC2nSDePw@mail.gmail.com>
 <CAOMZO5DN0KGvUBut0BqyvPTdyByWtZ=uamTpQGeENBzMOfJK3A@mail.gmail.com>
Message-ID: <20131029185352.GT16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 29, 2013 at 01:45:50PM -0200, Fabio Estevam wrote:
> On Tue, Oct 29, 2013 at 1:00 PM, Fabio Estevam <festevam@gmail.com> wrote:
> 
> > Today I was able to get access to a wandboard solo and the HDMI image
> > does look different compared to a wandboard quad board:
> >
> > - The Linux logo penguins are steady on mx6q, but on mx6solo the
> > contour lines look like they flicker.
> > - The kernel log text appears in good white colour with mx6q, but not
> > so white on mx6solo (tending to green).
> >
> > Even the U-boot HDMI splash screen is not very steady on mx6solo.
> >
> > I will try to look at these mx6 solo HDMI issues.
> 
> With the change below I am able to get a good HDMI quality image on
> mx6solo (and mx6quad as well):

Yes, I need that too on the Carrier-1 board, as suggested by Sascha.
