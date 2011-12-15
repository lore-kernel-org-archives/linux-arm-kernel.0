From: linux_arm@lakedaemon.net (Jason)
Date: Thu, 15 Dec 2011 11:10:05 -0500
Subject: [PATCH 0/4] [orion] move *_mbus_dram_info out of platform_data
In-Reply-To: <1321599572-705-1-git-send-email-andrew@lunn.ch>
References: <1321599572-705-1-git-send-email-andrew@lunn.ch>
Message-ID: <20111215161005.GP23844@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andrew,

On Fri, Nov 18, 2011 at 07:59:28AM +0100, Andrew Lunn wrote:
> Boot tested on kirkwood, compile tested on other orion based systems.
> 
> Andrew Lunn (4):
>   [orion] Consolidate the address map setup on Orion based platforms.
>   [orion] Move the *_mbus_dram_info structure into the orion platform  
>       and call it orion_mbus_dram_info everywhere.
>   [orion] Get address map from plat-orion instead of via platform_data.
>   [orion] Remove address map info from all platform data strucutures.

Do you have a public git tree I could pull from?  I'd like to assist
with testing / contributing towards this.  If you've started on a
kirkwood.dtsi I could base off of, that would be great.

thx,

Jason.
