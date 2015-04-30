From: msalter@redhat.com (Mark Salter)
Date: Thu, 30 Apr 2015 10:46:13 -0400
Subject: [PATCH V2] drivers: CCI: fix used_mask init in validate_group()
In-Reply-To: <20150430143852.GC32190@leverpostej>
References: <20150409144029.GE9648@leverpostej>
 <1428591425-17330-1-git-send-email-msalter@redhat.com>
 <20150409153629.GI9648@leverpostej> <20150413124121.GF2869@arm.com>
 <55420A18.7080203@arm.com> <1430400394.24034.67.camel@deneb.redhat.com>
 <20150430133333.GB32190@leverpostej>
 <1430402587.24034.68.camel@deneb.redhat.com>
 <20150430143852.GC32190@leverpostej>
Message-ID: <1430405173.24034.73.camel@deneb.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2015-04-30 at 15:38 +0100, Mark Rutland wrote:
> On Thu, Apr 30, 2015 at 03:03:07PM +0100, Mark Salter wrote:
> > On Thu, 2015-04-30 at 14:33 +0100, Mark Rutland wrote:
> > > > > Could you please send this to arm-soc as suggested by Will, with the 
> > > > > relevant acks/reviews  ?
> > > > > 
> > > > 
> > > > I sent it on Tuesday. Did it not show up? Is arm at kernel.org the correct
> > > > address? I got the cc:
> > > > 
> > > > From: Mark Salter <msalter@redhat.com>
> > > > To: arm at kernel.org
> > > > Cc: Mark Salter <msalter@redhat.com>
> > > > Subject: [PATCH V2] drivers: CCI: fix used_mask init in validate_group()
> > > > Date: Tue, 28 Apr 2015 13:09:32 -0400
> > > > Message-Id: <1430240972-16386-1-git-send-email-msalter@redhat.com>
> > > 
> > > That's the right address, but that only goes to the maintainers, and
> > > doesn't get copied to any list. In future, please Cc linux-arm-kernel in
> > > addition.
> > 
> > That's where I sent it originally.
> 
> Sure, but it's good to Cc when sending to arm-soc so as to make it
> visible that the patches have been sent. Doing so avoids the necessity
> of queries like Suzuki's, and makes it possible for others to reply to
> the version sent to arm at kernel.org in the case of conflicts or other
> issues.

But why did it need to be sent to a private maintainer's list in the
first place? I think that the destination addresses of the original
posting was perfectly reasonable given output from get_maintainer.pl
and that sending me to a private list was an unnecessary hoop to
jump through.
