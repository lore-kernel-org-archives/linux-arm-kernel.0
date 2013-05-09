From: olof@lixom.net (Olof Johansson)
Date: Thu, 9 May 2013 13:44:34 -0700
Subject: [PATCH V2] ARM: bcm281xx: Add L2 support for Rev A2 chips
In-Reply-To: <1367542653-955-1-git-send-email-csd@broadcom.com>
References: <1367542653-955-1-git-send-email-csd@broadcom.com>
Message-ID: <20130509204434.GA16724@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 02, 2013 at 05:57:33PM -0700, Christian Daudt wrote:
> Rev A2 SoCs have an unorthodox memory re-mapping and this needs
> to be reflected in the cache operations.
> This patch adds new outer cache functions for the l2x0 driver
> to support this SoC revision. It also adds a new compatible
> value for the cache to enable this functionality.
> 
> Updates from V1:
> - remove section 1 altogether and note that in comments
> - simplify section selection caused by section 1 removal
> - BUG_ON just in case section 1 shows up
> 
> Signed-off-by: Christian Daudt <csd@broadcom.com>

This patch mostly covers code that is on Russells plate, so please feed
this to his tracker to be picked up by him. Feel free to add:

Acked-by: Olof Johansson <olof@lixom.net>


Thanks,

-Olof
