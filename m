From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 22 May 2011 10:11:36 +0100
Subject: Updated mach-types update
In-Reply-To: <BANLkTi=buKPmceOhF=SU6kkYRPxsJMn6hA@mail.gmail.com>
References: <20110320110322.GC16646@n2100.arm.linux.org.uk>
	<BANLkTi=buKPmceOhF=SU6kkYRPxsJMn6hA@mail.gmail.com>
Message-ID: <20110522091136.GC17672@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 21, 2011 at 09:35:29AM +0800, Jaya Kumar wrote:
> On Sun, Mar 20, 2011 at 7:03 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> >
> > What this means is that any platform in the machine database which has not
> > been submitted to mainline for 12 months since it was registered will be
> > automatically dropped from the file, and the platform maintainer will need
> > to either talk to me to get it reinstated before submission, or update the
> > entry in some way to 'freshen' it.
> >
> 
> Hi Russell,
> 
> Apologies, I just realized this patch removed an entry for a board I
> am working with. Could you reinstate the following entry:
> 
> 2363  	WAYLAND  	wayland  	Ofer Zaarur
> 
> I plan to submit support for this board as soon as I can.

I'm not sure how that squares with Linus' complaint during the last merge
window - I'm currently nervous about sending Linus updates to mach-types
as it is.  Maybe our new sub-architecture people can comment on their
perception of the situation with new board support.
