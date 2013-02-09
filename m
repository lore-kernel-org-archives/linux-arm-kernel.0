From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 08 Feb 2013 20:47:36 -0700
Subject: [PATCH 2/4] clocksource: bcm2835: use the device_node pointer
 passed to init
In-Reply-To: <1360264144-20714-3-git-send-email-robherring2@gmail.com>
References: <1360264144-20714-1-git-send-email-robherring2@gmail.com>
 <1360264144-20714-3-git-send-email-robherring2@gmail.com>
Message-ID: <5115C6D8.5040404@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/07/2013 12:09 PM, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> We've already matched the node, so use the node pointer passed in.

Patches 1 & 2,

Tested-by: Stephen Warren <swarren@wwwdotorg.org>

(i.e. with my bcm2835 hat on:-)
