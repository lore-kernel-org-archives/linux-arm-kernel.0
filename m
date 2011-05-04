From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 4 May 2011 11:23:32 +0200
Subject: [PATCH] kirkwood: add dir-665 support
In-Reply-To: <1303922086-10531-1-git-send-email-camhirundo@gmail.com>
References: <1303922086-10531-1-git-send-email-camhirundo@gmail.com>
Message-ID: <20110504092332.GS11267@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 00:34 Thu 28 Apr     , Hirundo Cam wrote:
> This patch is a hack to dir-665 by referencing mv88f6281gtw_ge board.
> LEDs, GPIO, Buttons remains unknown.
> 
> To use this patch, u-boot must also be modified.
the kernel do not care about the bootloader

if the machine id is wrong you can use
devio to patch it

Best Regards,
J.
