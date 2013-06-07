From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 7 Jun 2013 20:50:15 +0200
Subject: [PATCH 2/2] ARM: dts: mvebu: Add the i2c-bridge capability to
 the mv64xxx-i2c
In-Reply-To: <20130607180941.GW23859@titan.lakedaemon.net>
References: <1370619743-15245-1-git-send-email-gregory.clement@free-electrons.com>
 <1370619743-15245-3-git-send-email-gregory.clement@free-electrons.com>
 <20130607180941.GW23859@titan.lakedaemon.net>
Message-ID: <20130607205015.0a6d6bfd@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jason Cooper,

On Fri, 7 Jun 2013 14:09:41 -0400, Jason Cooper wrote:

> > +- i2c,i2c-bridge : This flag indicate that the i2c controller have the
> > +  Transaction Generator support and we want to use it. Not all the
> > +  mv64xxx controller have this feature.
> 
> Do you have a list of which controllers definitely do, or definitely
> don't?  That would be helpful for folks adding new boards.

As mentioned in the first commit log:

""
This feature is currently only available on Armada XP, so usage of
this mechanism is activated through device tree.
""

So Armada XP is the only to have that, for now. We can probably assume
future Marvell SoC may also have this feature, but we don't know for
sure.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
