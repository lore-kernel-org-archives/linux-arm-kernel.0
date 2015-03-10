From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 10 Mar 2015 15:42:53 +0000
Subject: [GIT PULL v2] of: Add of-graph helpers to loop over endpoints
 and find ports by id
In-Reply-To: <1426001087.3141.46.camel@pengutronix.de>
References: <1425369592.3146.14.camel@pengutronix.de>
 <1426001087.3141.46.camel@pengutronix.de>
Message-ID: <20150310154253.GO8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 10, 2015 at 04:24:47PM +0100, Philipp Zabel wrote:
> Hi Grant, Rob,
> 
> Am Dienstag, den 03.03.2015, 08:59 +0100 schrieb Philipp Zabel:
> > Hi Grant, Rob,
> > 
> > this series has been around for quite some time now, basically unchanged
> > except for adding fixes for new users of the API that keep appearing
> > over time in different subsystems.
> > 
> > It would be really helpful to get this merged for v4.0. Could you still
> > make this happen?
> >
> > Alternatively, could I please get your ack to allow this tag to be
> > merged into the other subsystem trees for v4.1 so that patches that
> > depend on it don't have to wait for yet another merge window?
> 
> The question still stands. It would be great to hear from you and maybe
> get this change in at least in time for v4.1.

Let's look at the history.

10-03-2015: This reminder
03-03-2015: Pull request (ignored from what can be seen)
01-03-2015: Request from Laurent about what's happening
27-02-2015: Reminder
23-02-2015: Re-base (and version 8) due to conflicts
11-02-2015: Reminder
22-01-2015: Pull request
23-12-2014: Version 7

During that time, there's not been one peep from Rob or Grant on this.
At what point has there been enough pestering that it's sufficient to
bypass an apparently uninterested maintainer, who can't be bothered to
say yes or no to a set of patches?

For such a key subsystem in the kernel, this is bad.  If Grant isn't
interested in performing a maintainer role, I'd be willing to pick up
that function (which'll be ironic, because that's the kind of thing
that Linaro's been doing to me over the last few years... picking
stuff off my plate without any discussion or agreement with me first,
leaving me with almost nothing to do.  No, I'm not pissed at that...
not much.)

I guess if you were to submit patches to Andrew, Andrew may take them
in this circumstance and eventually send them on to Linus.  Andrew?

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
