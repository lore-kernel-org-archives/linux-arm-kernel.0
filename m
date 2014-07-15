From: horms@verge.net.au (Simon Horman)
Date: Tue, 15 Jul 2014 18:09:44 +0900
Subject: [GIT PULL v2 FOR v3.17] Renesas CMT, MTU2 and TMU timers DT
 support
In-Reply-To: <53C45179.4090100@linaro.org>
References: <1402931251-22581-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <4780671.lrfQIxTHV3@avalon> <20140713095457.GA21209@verge.net.au>
 <1929656.0uZaK89oG1@avalon> <53C29AC1.30606@linaro.org>
 <20140713203951.GA18891@verge.net.au> <53C45179.4090100@linaro.org>
Message-ID: <20140715090944.GF17806@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 14, 2014 at 11:54:01PM +0200, Daniel Lezcano wrote:
> On 07/13/2014 10:39 PM, Simon Horman wrote:
> >On Sun, Jul 13, 2014 at 04:42:09PM +0200, Daniel Lezcano wrote:
> >>On 07/13/2014 03:00 PM, Laurent Pinchart wrote:
> >>>Hi Simon and Daniel,
> >>>
> >>>On Sunday 13 July 2014 11:55:01 Simon Horman wrote:
> >>>>[Cc Olof Johansson, ARM SoC Team]
> >>>>
> >>>>On Wed, Jul 09, 2014 at 11:59:16AM +0200, Laurent Pinchart wrote:
> >>>>>On Friday 04 July 2014 15:53:32 Laurent Pinchart wrote:
> >>>>>>Hi Daniel,
> >>>>>>
> >>>>>>Could you please pull the following changes and drop the first version
> >>>>>>of this pull request ? I've fixed one last typo noticed by Simon in
> >>>>>>patch 09/19.
> >>>>>>
> >>>>>>As last time I have board and SoC changes that depend on the driver
> >>>>>>changes and that will need to go through Simon's tree. Could you thus
> >>>>>>please provide a stable branch based on one of the v3.16-rc tags ?
> >>>>>
> >>>>>Given that I'd like to get the arch/ part of the change set in v3.17,
> >>>>>could I ask you to fast track this pull request if possible ?
> >>>>
> >>>>Hi Laurent, Hi Daniel,
> >>>>
> >>>>I am wondering what the status of this pull request is.  It would be nice
> >>>>to get the arch/ changes into v3.17 but we are getting closer to v3.16-rc6
> >>>>and I need to have things queued up before then.
> >>>>
> >>>>I have also CCed Olof and the ARM SoC team (via arm at kernel.org) as
> >>>>if Daniel does provide a stable branch that includes this pull request and
> >>>>I use it as the basis for a branch with the arch changes then the
> >>>>ARM SoC people would like to know about it before I send a pull request
> >>>>for the arch/ changes.
> >>>
> >>> From my point of view everything is ready for v3.17. Daniel, if you haven't
> >>>been abducted by aliens, could you please process the pull request ? If you
> >>>have, let us know what we can do to help negotiate your release.
> >>
> >>Hi Laurent,
> >>
> >>sorry for no giving some news. I am in vacation for these two weeks.
> >>
> >>I will take care of the PR this evening or tomorrow evening and keep you in
> >>touch rapidly.
> >
> >Hi Daniel,
> >
> >thanks in advance. If you could create a stable branch for me to
> >use as a base for the arch/ patches that would be great.
> 
> 
> Hi Simon and Laurent,
> 
> I pulled in the following branch:
> 
> git://git.linaro.org/people/daniel.lezcano/linux.git
> clockevents/renesas-timers-dt
> 
> I will keep this branch untouched and it will be merge in the 3.17 branch.

Thanks!
