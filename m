From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 13 Mar 2014 11:44:33 -0600
Subject: [PATCH 1/2] ARM: DT: fix gic interrupt controller documentation
In-Reply-To: <1394732405-2260-2-git-send-email-tharvey@gateworks.com>
References: <1394732405-2260-1-git-send-email-tharvey@gateworks.com>
 <1394732405-2260-2-git-send-email-tharvey@gateworks.com>
Message-ID: <5321EE81.1030207@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/13/2014 11:40 AM, Tim Harvey wrote:
> When using interrupt-maps, the size of a map entry is #address-cells +
>  #interrupt-cells for the parent interrupt controller.  For the ARM GIC
> address-cells should be 0 as this is not used.
> 
> This patch fixes the example by correctly specifying #address-cells = 0.

If the #address-cells property is required (well, or even optional...)
in the node, shouldn't it be included in the list of required/optional
properties above, and not solely included in the example?
