From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 1 Oct 2013 09:37:36 -0400
Subject: [PATCH v3 2/2] ARM: kirkwood: Add standby support
In-Reply-To: <20130831161918.GA2404@localhost>
References: <1377186547-14284-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1377186547-14284-3-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130830231003.GA2398@localhost>
 <20130831155125.GY19598@titan.lakedaemon.net>
 <20130831161918.GA2404@localhost>
Message-ID: <20131001133736.GQ31178@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 31, 2013 at 01:19:19PM -0300, Ezequiel Garcia wrote:
> On Sat, Aug 31, 2013 at 11:51:25AM -0400, Jason Cooper wrote:
...
> > How about expanding the series to add proper suspend/resume support to
> > some of the more power hungry drivers
> 
> So -just to check- you definitely prefer not to take the stand-by
> support until we have some more suspend/resume support in other drivers?
> 
> If the stand-by is ready and it's working, I'd say we're ready to
> include it, disregarding the drivers, but it's completely your call.

Looking things over, most drivers we care about are missing
suspend/resume.  At some point I think it's reasonable to assume that
we'll do a sweep.  So I drop my objection to this.

Let's see how rmk wants to handle #1 and go from there.

thx,

Jason.
