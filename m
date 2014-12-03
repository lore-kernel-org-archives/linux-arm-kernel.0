From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 03 Dec 2014 10:51:53 +0100
Subject: [PATCHv2 0/4] LS1021A: Add dcfb framebuffer driver support.
In-Reply-To: <1417598162-40433-1-git-send-email-Li.Xiubo@freescale.com>
References: <1417598162-40433-1-git-send-email-Li.Xiubo@freescale.com>
Message-ID: <4810522.t9QFQYHtHI@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 03 December 2014 17:15:58 Xiubo Li wrote:
> Framebuffer driver for the Freescale SoC Display Controller.
> 
> 
> Change in V2:
> - Use the native-mode timing as default.
> - Add to_fsl_private().

<standard reply>

We try to not have any new framebuffer drivers. Please consider making
this a DRM/KMS driver instead.

</standard reply>

	Arnd
