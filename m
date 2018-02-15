From: horms@verge.net.au (Simon Horman)
Date: Thu, 15 Feb 2018 16:45:34 +0100
Subject: [PATCH 13/15] Documentation: devicetree: ravb: Add r8a77965
In-Reply-To: <1518515162-23663-14-git-send-email-jacopo+renesas@jmondi.org>
References: <1518515162-23663-1-git-send-email-jacopo+renesas@jmondi.org>
 <1518515162-23663-14-git-send-email-jacopo+renesas@jmondi.org>
Message-ID: <20180215154235.ndpizqzkciqyifun@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 13, 2018 at 10:46:00AM +0100, Jacopo Mondi wrote:
> Add documentation for r8a77965 compatible string to renesas ravb device
> tree bindings documentation.
> 
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

This needs to be CCed to Sergei and netdev to proceed into mainline.

There are lot of examples and little consistency, but I believe a good
prefix and subject for the patch would be:

dt-bindings: net: ravb: Add support for r8a77965 SoC
