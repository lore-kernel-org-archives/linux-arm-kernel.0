From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 23 Apr 2015 22:27:14 -0600
Subject: [PATCH 1/9] dt-bindings: Add root properties for Raspberry Pi 2.
In-Reply-To: <1429639796-2169-2-git-send-email-eric@anholt.net>
References: <1429639796-2169-1-git-send-email-eric@anholt.net>
 <1429639796-2169-2-git-send-email-eric@anholt.net>
Message-ID: <5539C622.2020208@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/21/2015 12:09 PM, Eric Anholt wrote:
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---
>  Documentation/devicetree/bindings/arm/bcm2836.txt | 10 ++++++++++

In next-20150423 at least, the bcm2835 equivalent of this file is:
Documentation/devicetree/bindings/arm/bcm/brcm,bcm2835.txt

The file added by this patch should be named consistently. I might be
tempted to put the new values into the existing file?
