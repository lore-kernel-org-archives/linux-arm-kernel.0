From: ijc@hellion.org.uk (Ian Campbell)
Date: Thu, 06 Feb 2014 16:39:25 +0000
Subject: [PATCH 4/4] ARM: Kirkwood: Add support for many Synology NAS
 devices
In-Reply-To: <20140206153939.GD8533@titan.lakedaemon.net>
References: <1391634309-3123-1-git-send-email-andrew@lunn.ch>
 <1391634309-3123-5-git-send-email-andrew@lunn.ch>
 <20140206153939.GD8533@titan.lakedaemon.net>
Message-ID: <1391704765.2162.7.camel@kazak.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2014-02-06 at 10:39 -0500, Jason Cooper wrote:
> 
> > +                     pmx_fan_33: pmx-fan-33 {
> > +                             marvell,pins = "mpp33";
> > +                             marvell,function = "gpo";
> > +                     }; 

Typo I think.

Ian.
