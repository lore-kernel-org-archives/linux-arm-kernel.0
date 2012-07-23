From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 23 Jul 2012 15:29:57 -0600
Subject: [PATCH V3 1/2] of: Add generic device tree DMA helpers
In-Reply-To: <201207171924.33756.arnd@arndb.de>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com>
 <201206271520.49276.arnd@arndb.de> <1342161907.1726.26.camel@vkoul-udesk3>
 <201207171924.33756.arnd@arndb.de>
Message-ID: <500DC255.40900@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/17/2012 01:24 PM, Arnd Bergmann wrote:
...
> I think we're basically on the same page. Let's see if I have covered
> all the cases we discussed so far. I've tried to update the binding that
> Jon sent out initially with everything we've discussed, so please review
> this to see if I understood you correctly.
...
> * DMA client
...
> Examples:
...
> 3. A device with three channels, one of which has two alternatives:

s/three/four/   s/one of which/both of which/

This binding doc seems reasonable to me.
