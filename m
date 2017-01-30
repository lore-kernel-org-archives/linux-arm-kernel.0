From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Mon, 30 Jan 2017 22:37:59 +0100 (CET)
Subject: [PATCH 1/4] dt-bindings: Add binding for brcm,bcm2835-sdhost.
In-Reply-To: <1485516989-1072-2-git-send-email-kraxel@redhat.com>
References: <1485516989-1072-1-git-send-email-kraxel@redhat.com>
 <1485516989-1072-2-git-send-email-kraxel@redhat.com>
Message-ID: <2012885435.15821.1485812279271@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Gerd Hoffmann <kraxel@redhat.com> hat am 27. Januar 2017 um 12:36 geschrieben:
> 
> 
> From: Eric Anholt <eric@anholt.net>
> 
> This is the other SD controller on the platform, which can be swapped
> to the role of SD card host using pin muxing.

AFAIK the SDHOST controller isn't able to handle SDIO. Maybe we should mention this in the binding document.
