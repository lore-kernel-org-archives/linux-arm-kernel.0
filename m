From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 18 Apr 2014 09:31:53 -0400
Subject: [PATCH 0/4] Add a DT description of LaCie 2Big and 5Big Network v2
In-Reply-To: <20140417175629.GW27979@kw.sim.vm.gnt>
References: <1397750938-25381-1-git-send-email-andrew@lunn.ch>
 <20140417175629.GW27979@kw.sim.vm.gnt>
Message-ID: <20140418133153.GZ28159@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 17, 2014 at 07:56:29PM +0200, Simon Guinot wrote:
> On Thu, Apr 17, 2014 at 06:08:54PM +0200, Andrew Lunn wrote:
> > This patchset adds a DT description for LaCie 2Big and 5Big, one of
> > the last remaining boards in mach-kirkwood. The LEDs cannot be
> > described in DT, since there is no binding yet for the device which
> > controls them. So a board file is added for that part.
> > 
> > These patches are build tested only. It would be good if somebody
> > could boot them.
> 
> Hi Andrew,
> 
> Unfortunately, I won't be able to test this patches before two weeks.

Once we address your other comments and figure out the led driver, I'll
get these up in mvebu's for next.  That way, anyone with the board can
test easily and report back.  There's plenty of time before the merge
window to add your Tested-by.

thx,

Jason.
