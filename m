From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Fri, 13 Nov 2015 13:56:29 -0300
Subject: [PATCH 1/2] ARM: ux500: remove regulator-compatible usage
In-Reply-To: <1443189092-16430-1-git-send-email-javier@osg.samsung.com>
References: <1443189092-16430-1-git-send-email-javier@osg.samsung.com>
Message-ID: <5646163D.6090804@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 09/25/2015 09:51 AM, Javier Martinez Canillas wrote:
> The regulator-compatible property from the regulator DT binding was
> deprecated and the correct approach is to use the node's name.
> 
> This patch has no functional changes since the values of the node's
> name and the regulator-compatible match for all the regulators.
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> 

Any comments about this patch?

Same question about patch 2/2: https://lkml.org/lkml/2015/9/25/288

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
