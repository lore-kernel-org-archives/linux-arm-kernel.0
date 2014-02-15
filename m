From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 14 Feb 2014 23:33:09 -0700
Subject: [PATCH V2] ARM: bcm2835: node name unit address cleanup
In-Reply-To: <1392357884-17682-1-git-send-email-swarren@wwwdotorg.org>
References: <1392357884-17682-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <52FF0A25.3080208@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/13/2014 11:04 PM, Stephen Warren wrote:
> DT nodes that contain a reg property should include a unit address in
> their name. Add the missing unit addresses.
> 
> The unit address in a node name must match the value in the reg property.
> Fix the cases where they don't match.
> 
> Don't fix the /clocks/* node names yet; that causes problems the clock
> driver to attempt to register multiple clocks with the same name, which
> fails.

I've applied this to bcm2835's for-3.15/dt branch.
