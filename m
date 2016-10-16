From: sylvain.rochet@finsecur.com (Sylvain Rochet)
Date: Sun, 16 Oct 2016 22:39:21 +0200
Subject: [PATCH] watchdog: at91sam9: keep watchdog running in idle mode
In-Reply-To: <59c665f8-de09-c11c-f62a-5064016cd8fd@roeck-us.net>
References: <1444163325-3041-1-git-send-email-sylvain.rochet@finsecur.com>
 <20151007110112.GD3485@piout.net>
 <20161016153316.rsrcgnki6kn7gola@finsecur.com>
 <67fe262e-31e4-b9dc-da71-af601079bfec@roeck-us.net>
 <59c665f8-de09-c11c-f62a-5064016cd8fd@roeck-us.net>
Message-ID: <20161016203921.aq2iffthlowncisa@finsecur.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Guenter,

On Sun, Oct 16, 2016 at 08:55:41AM -0700, Guenter Roeck wrote:
> On 10/16/2016 08:50 AM, Guenter Roeck wrote:
> > On 10/16/2016 08:33 AM, Sylvain Rochet wrote:
> > > 
> > > Looks like this one falls through the cracks, it didn't reach mainline
> > > and therefore wasn't applied to stable branches.
> > 
> > Possibly that happened because you did not copy the watchdog mailing list.
> 
> ... and your other patches were not sent to the watchdog mailing list either,
> so you should not expect them to be picked up either.
> 
> Seriously, how do you expect _any_ patch to be picked up if you neither copy
> the subsystem mailing list nor the subsystem maintainer ?

Whoops, thanks for the heads up, I wonder how I managed to mess up that 
at that time, I usually take care of that. The other series need 
respinning anyway so I can fix it for v2 (if any).

Cheers,
Sylvain
