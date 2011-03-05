From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 5 Mar 2011 14:08:48 +0000
Subject: [PATCH V6 0/8] SPEAr3xx & SPEAr6xx Fixes
In-Reply-To: <20110305140441.GE27468@n2100.arm.linux.org.uk>
References: <cover.1298977691.git.viresh.kumar@st.com>
	<20110305140243.GD27468@n2100.arm.linux.org.uk>
	<20110305140441.GE27468@n2100.arm.linux.org.uk>
Message-ID: <20110305140848.GA6846@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 05, 2011 at 02:04:41PM +0000, Russell King - ARM Linux wrote:
> On Sat, Mar 05, 2011 at 02:02:43PM +0000, Russell King - ARM Linux wrote:
> > On Tue, Mar 01, 2011 at 04:56:06PM +0530, Viresh Kumar wrote:
> > > This patchset contains minor fixes, renames, & reordering of code of #include
> > > files.
> > 
> > This set looks absolutely fine.  I assume that it should apply on top of
> > my 'spear' branch?  If so, please submit this series to the patch system,
> > thanks.
> 
> BTW, please drop the 'ST ' from the subject lines, I don't think there's
> any other SPEAr which it could be confused with.
> 
> For 'ST SPEAr Clock Framework: ...' please use 'SPEAr: Clock Framework: ...'
> instead.

One last comment on the subject lines - please don't use 'Replacing' etc,
but 'Replace' - as the replacement is not an ongoing exercise.  Same for
other patches which use '-ing' verbs in their subject.
