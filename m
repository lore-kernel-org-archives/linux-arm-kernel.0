From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 3 Mar 2016 14:09:22 -0700
Subject: [PATCH] pinctrl-bcm2835: Fix cut-and-paste error in "pull" parsing
In-Reply-To: <1456795808-1449-1-git-send-email-eric@anholt.net>
References: <1456795808-1449-1-git-send-email-eric@anholt.net>
Message-ID: <56D8A802.8040307@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/29/2016 06:30 PM, Eric Anholt wrote:
> From: Phil Elwell <phil@raspberrypi.org>
>
> The DT bindings for pinctrl-bcm2835 allow both the function and pull
> to contain either one entry or one per pin. However, an error in the
> DT parsing can cause failures if the number of pulls differs from the
> number of functions.
>
> Signed-off-by: Eric Anholt <eric@anholt.net>
> Cc: stable at vger.kernel.org
> ---
>
> Yes, the s-o-b differs from the author of the commit, but this falls
> under part b) of the process.

I'd argue that part (b) only applies if the s-o-b line is present in the 
original, otherwise I'm not sure how it's clear the author intended to 
publish their source under the license in question. That's why I've 
always beedn careful to go back and ask the original author to give 
their s-o-b, like you did. Some commits at least in the earlier Pi 
Foundation kernels also clearly had incorrect git author values, or were 
squashed together forms of multiple peoples' work:-(

Luckily it's a moot point since Phil gave his s-o-b.

Reviewed-by: Stephen Warren <swarren@wwwdotorg.org>

Does a similar bug exist in any other pinctrl drivers?
