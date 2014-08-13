From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 13 Aug 2014 10:12:12 -0600
Subject: [PATCH 1/6] ARM: dts: Create fragment for tps65090 PMU
In-Reply-To: <1407861868-20097-2-git-send-email-javier.martinez@collabora.co.uk>
References: <1407861868-20097-1-git-send-email-javier.martinez@collabora.co.uk>
 <1407861868-20097-2-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <53EB8E5C.3030902@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/12/2014 10:44 AM, Javier Martinez Canillas wrote:
> The tps65090 is a Power Management Unit (PMU) used in several
> boards so the same information is described on different DTS.
> It is better to create a .dtsi fragment that can be included.

To be honest, I'm not sure that this file is useful. The entire content 
of this file (with the exception of the compatible value and possibly 
the charger sub-node) needs to be repeated in any file that includes it, 
in order to add properties into all the nodes.
