From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 28 Apr 2014 14:05:59 -0600
Subject: [PATCH 49/97] ARM: l2c: fix register naming
In-Reply-To: <E1WerFu-0001Wq-BX@rmk-PC.arm.linux.org.uk>
References: <20140428192419.GV26756@n2100.arm.linux.org.uk>
 <E1WerFu-0001Wq-BX@rmk-PC.arm.linux.org.uk>
Message-ID: <535EB4A7.1090007@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/28/2014 01:30 PM, Russell King wrote:
> We have a mixture of different devices with different register layouts,
> but we group all the bits together in an opaque mess.  Split them out
> into those which are L2C-310 specific and ones which refer to earlier
> devices.  Provide full auxiliary control register definitions.

Acked-by: Stephen Warren <swarren@nvidia.com>
