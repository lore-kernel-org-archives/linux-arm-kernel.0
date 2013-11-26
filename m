From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 26 Nov 2013 11:03:37 -0500
Subject: [RESEND PATCH v2 2/3] ARM: Dove: Add DT node for PMU interrupt
 controller.
In-Reply-To: <5294C52E.2000603@gmail.com>
References: <1383820531-4387-1-git-send-email-andrew@lunn.ch>
 <1383820531-4387-2-git-send-email-andrew@lunn.ch>
 <20131126151806.GL2879@titan.lakedaemon.net>
 <5294C52E.2000603@gmail.com>
Message-ID: <20131126160337.GM2879@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 26, 2013 at 04:58:38PM +0100, Sebastian Hesselbarth wrote:
> On 11/26/2013 04:18 PM, Jason Cooper wrote:
> >On Thu, Nov 07, 2013 at 11:35:30AM +0100, Andrew Lunn wrote:
> >>Instantiate the PMU interrupt controller which Dove has.
> >>
> >>Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> >>Tested-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> >>---
> >>  arch/arm/boot/dts/dove.dtsi | 9 +++++++++
> >>  1 file changed, 9 insertions(+)
> >
> >Could you rebase #2 and #3 on v3.13-rc1?  The dove.dtsi reshuffle last
> >window is annoying the piss out of me :)
> 
> Jason,
> 
> IIRC Andrew isn't available till beginning of Dec. I can rebase if you
> want.

Ahh, ok.  No problem, I'll knock it out.

thx,

Jason.
