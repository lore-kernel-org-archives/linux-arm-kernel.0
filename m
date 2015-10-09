From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 9 Oct 2015 17:11:52 +0100
Subject: [PATCH 1/9] drm: bridge/dw_hdmi-ahb-audio: add audio driver
In-Reply-To: <CAOMZO5Ah=AKXr__uuYsYp1KvSHptVp1NR7YUr7akzQJ3xW2XiA@mail.gmail.com>
References: <20150808160936.GN7557@n2100.arm.linux.org.uk>
 <E1ZO6hC-0003M5-EU@rmk-PC.arm.linux.org.uk>
 <CAOMZO5COgoGU-3YNpnmSkctHMRDJ3=DuKc82Wb5zTTX7Bx2jNw@mail.gmail.com>
 <20151006181806.GS21513@n2100.arm.linux.org.uk>
 <CAOMZO5DaowTGQqN_NW7T2zv-P6a_YZUCumq4-m+OtpsKqFzELw@mail.gmail.com>
 <20151006185429.GU21513@n2100.arm.linux.org.uk>
 <CAOMZO5C8O0p6C0hrAvHzanru9W2f8-C7MWsm3+HumoyZ9Hu6Jw@mail.gmail.com>
 <20151009160036.GZ32532@n2100.arm.linux.org.uk>
 <CAOMZO5Ah=AKXr__uuYsYp1KvSHptVp1NR7YUr7akzQJ3xW2XiA@mail.gmail.com>
Message-ID: <20151009161152.GB32532@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 09, 2015 at 01:02:11PM -0300, Fabio Estevam wrote:
> On Fri, Oct 9, 2015 at 1:00 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> 
> >> Thanks, Russell!
> >>
> >> Got audio to play on my HDMI TV :-)
> >>
> >> For the entire series:
> >>
> >> Tested-by: Fabio Estevam <fabio.estevam@freescale.com>
> >
> > Just to confirm - that's for _all_ of these 8 patches, including the
> > changes to the ACR code in the last four patches, and you're happy that
> > I send all of these:
> >
> > drm: bridge/dw_hdmi-ahb-audio: add audio driver
> > drm: bridge/dw_hdmi-ahb-audio: parse ELD from HDMI driver
> > drm: bridge/dw_hdmi-ahb-audio: basic support for multi-channel PCM audio
> > drm: bridge/dw_hdmi-ahb-audio: allow larger buffer sizes
> > drm: bridge/dw_hdmi: avoid being recursive in N calculation
> > drm: bridge/dw_hdmi: adjust pixel clock values in N calculation
> > drm: bridge/dw_hdmi: remove ratio support from ACR code
> > drm: bridge/dw_hdmi: replace CTS calculation for the ACR
> 
> That's correct. Thanks, Russell

Thanks.  I'll drop that set into linux-next tonight, along with the TDA998x
and Armada DRM patches that haven't seen an airing there yet - before asking
David to pull them next week (the timescale has slipped...)

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
