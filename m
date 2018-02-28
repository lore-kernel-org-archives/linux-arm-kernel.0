From: will.deacon@arm.com (Will Deacon)
Date: Wed, 28 Feb 2018 16:18:33 +0000
Subject: Internal error: Oops - BUG() / kvm boot race - arm64 kpti
 patchset related
In-Reply-To: <20180228161256.GA31013@akinoame>
References: <20180228154523.GA29931@akinoame> <20180228160735.GA22612@arm.com>
 <20180228161256.GA31013@akinoame>
Message-ID: <20180228161833.GB22612@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 28, 2018 at 05:12:56PM +0100, Paolo Pisati wrote:
> On Wed, Feb 28, 2018 at 04:07:35PM +0000, Will Deacon wrote:
> > On Wed, Feb 28, 2018 at 04:45:23PM +0100, Paolo Pisati wrote:
> > > Reproducible on 4.16-rc3 and 4.4.20 using defconfig - the failure it's
> > > intermittent, but i could reproduce it 100% if i boot loop the kvm instance 
> > > (it usually shows up in less than 10 iterations but i tested 32 boots before
> > > marking it good).
> > 
> > [...]
> > 
> > > Anything else i can do to help debug this?
> > 
> > If you could share the crash log, that would be helpful.
> 
> Oops log here:
> https://launchpadlibrarian.net/358687166/submission_2018-02-26T14.58.17.996524.html#9-1-log

The patch that Ard linked to should resolve that particular crash.
I see this is a 4.13-based kernel. Is the source tree available anywhere?

Will
