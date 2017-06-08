From: tony@atomide.com (Tony Lindgren)
Date: Thu, 8 Jun 2017 04:10:40 -0700
Subject: [PATCH 04/11] ARM: OMAP2+: Remove unused legacy code for device
 init
In-Reply-To: <20170608105553.dq7rhfwhvz3wwa3e@earth>
References: <20170531225139.30723-1-tony@atomide.com>
 <20170531225139.30723-5-tony@atomide.com>
 <20170607222711.6kdhuvkymiseootn@earth>
 <20170608082825.GG3730@atomide.com>
 <20170608094712.GI3730@atomide.com>
 <20170608105553.dq7rhfwhvz3wwa3e@earth>
Message-ID: <20170608111040.GL3730@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Sebastian Reichel <sebastian.reichel@collabora.co.uk> [170608 03:59]:
> On Thu, Jun 08, 2017 at 02:47:12AM -0700, Tony Lindgren wrote:
> > Here's this one updated.
> 
> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

Thanks for looking.

> Defines for L3_MODULES_MAX_LEN + L3_MODULES and most of the includes
> could be dropped now.

Yeah I bet we have tons of unused defines now. I think
I used to have some shell script to grep for those
somewhere.

Regards,

Tony
