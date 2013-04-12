From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Fri, 12 Apr 2013 11:58:21 +0100
Subject: [PATCH 0/4 v6] arm: introduce psci_smp_ops and use them on Xen
In-Reply-To: <20130412085748.GC12363@mudshark.cambridge.arm.com>
References: <alpine.DEB.2.02.1304031239550.5078@kaball.uk.xensource.com>
 <alpine.DEB.2.02.1304081102500.5353@kaball.uk.xensource.com>
 <20130411082519.GD31465@quad.lixom.net> <51671A39.6090105@gmail.com>
 <20130412085748.GC12363@mudshark.cambridge.arm.com>
Message-ID: <alpine.DEB.2.02.1304121152310.7254@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 12 Apr 2013, Will Deacon wrote:
> On Thu, Apr 11, 2013 at 09:16:57PM +0100, Rob Herring wrote:
> > On 04/11/2013 03:25 AM, Olof Johansson wrote:
> > > On Mon, Apr 08, 2013 at 12:05:17PM +0100, Stefano Stabellini wrote:
> > >> Arnd, Olof,
> > >> do you have any thoughts on this series?
> > >> Would you be happy to carry it in the arm-soc tree?
> > >>
> > >> The last patch, "xen/arm: introduce xen_early_init, use PSCI on xen" has
> > >> a (small) dependency on this series:
> > >>
> > >> http://marc.info/?l=linux-kernel&m=136430893610688&w=2
> > >>
> > >> would you be OK with taking that one too, or should that go through the
> > >> Xen tree?
> > > 
> > > I think it'd make sense to get Russell to ack the changes to the core ARM code.
> > > We can merge the series through arm-soc, or he can take them, whatever is
> > > easiest for everybody.
> > > 
> > > Given the dependencies on the second branch it might be easier to merge
> > > through Russell's tree.
> > 
> > I'm also dependent on the 1st patch for converting highbank to use PSCI
> > and am just waiting on a stable branch to base it on. I believe Russell
> > said he is offline for the next week.
> 
> By the first patch, do you just mean 6/6 in that series ("[RFC] arm: use PSCI if
> available"), or do you have dependencies on others in that series too?
 
FYI in few days, as soon as I am back from vacation, I am planning on
sending out a single patch series to avoid further confusions. I'll also
include the new version of the smp_init patch, as requested by Nicolas.

Of course we'll still need all the acks from Russell.
