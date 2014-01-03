From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 3 Jan 2014 16:29:33 +0000
Subject: [PATCH RFC 21/46] drm: provide a helper for the encoder
 possible_crtcs mask
In-Reply-To: <CANq1E4T8__+Xy8Ka1em9gADknCj-k754RcZA7P1=oKhimUUTOg@mail.gmail.com>
References: <20140102212528.GD7383@n2100.arm.linux.org.uk>
 <E1Vypnh-0007Ev-3v@rmk-PC.arm.linux.org.uk>
 <CANq1E4RanNbeeh4YDLJuHMgSPStHaVN7wCD-dU-BT=3ohL7e1Q@mail.gmail.com>
 <20140103161320.GR7383@n2100.arm.linux.org.uk>
 <CANq1E4T8__+Xy8Ka1em9gADknCj-k754RcZA7P1=oKhimUUTOg@mail.gmail.com>
Message-ID: <20140103162933.GS7383@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 03, 2014 at 05:26:14PM +0100, David Herrmann wrote:
> Hi
> 
> On Fri, Jan 3, 2014 at 5:13 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > I'm not so sure - since the only place this mask gets used is with
> > the "possible_crtcs" field.  It's got nothing to do with the
> > "possible_clones" field as that isn't a mask of CRTCs.
> 
...
> possible_clones is about encoders, you're right, I missed that. So you
> can carry it in your series just fine.

Thanks for confirming that - it's something which imx-drm seemed to get
wrong as put the same value into possible_clones as it did for
possible_crtcs.  I was fairly certain that was buggy. :)

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
