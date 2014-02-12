From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 12 Feb 2014 12:45:17 +0000
Subject: [PATCH RFC v2 00/35] Second preview of imx-drm cleanup series
In-Reply-To: <CAH9NwWcEAg461_aZrRjZ4o80M4ymhsg9bqsRVuVa8T1BEwAHOQ@mail.gmail.com>
References: <20140210122802.GS26684@n2100.arm.linux.org.uk>
 <CAOMZO5A=4NS3J365+JQMnyNSfwdiPqTy4gDwNcwV2_ECySTBQg@mail.gmail.com>
 <CAH9NwWcEAg461_aZrRjZ4o80M4ymhsg9bqsRVuVa8T1BEwAHOQ@mail.gmail.com>
Message-ID: <20140212124517.GO26684@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 12, 2014 at 01:04:30PM +0100, Christian Gmeiner wrote:
> 2014-02-12 12:53 GMT+01:00 Fabio Estevam <festevam@gmail.com>:
> > On Mon, Feb 10, 2014 at 10:28 AM, Russell King - ARM Linux
> > <linux@arm.linux.org.uk> wrote:
> >> This is the latest revision of my series cleaning up imx-drm and
> >> hopefully getting it ready to be moved out of drivers/staging.
> >> This series is updated to v3.14-rc2.
> >>
> >> Since the last round of patches were posted, the component support
> >> has been merged into mainline, and thus dropped from this series.
> >> Greg has taken the first three patches and merged them into his
> >> linux-next tree - however, I include them here for completness.
> >>
> >> Most of the comments from last time still apply, and I'll look at
> >> incorporating some of the other patches that were posted in the
> >> coming week.
> >>
> >> If I can have some acks for this, I'll start sending some of it to
> >> Greg - I'd like to at least get the five or six initial imx-hdmi
> >> patches to Greg and queued up for the next merge window sooner
> >> rather than later, preferably getting most of this ready for that
> >> window too.
> >
> > Series looks good:
> >
> > Reviewed-by: Fabio Estevam <fabio.estevam@freescale.com>
> >
> > Patch 04/35 will not be needed in the final submission, as there is
> > already a fix for the build issue in Greg's tree.
> >
> 
> I am the only one who does not get the whole series?
> 
> Even here ony a handfull of patches are listed:
> http://www.spinics.net/lists/arm-kernel/threads.html#306292

You will find it all on the devel at driverdev.osuosl.org archive.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
