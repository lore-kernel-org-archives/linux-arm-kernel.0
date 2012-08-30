From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 30 Aug 2012 19:14:46 +0200
Subject: [PATCH 05/10] ARM: at91: explicitly include mach/gpio.h
In-Reply-To: <1346279496-26286-6-git-send-email-robherring2@gmail.com>
References: <1346279496-26286-1-git-send-email-robherring2@gmail.com>
 <1346279496-26286-6-git-send-email-robherring2@gmail.com>
Message-ID: <20120830171446.GC7629@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17:31 Wed 29 Aug     , Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> In preparation to remove implicit inclusion of mach/gpio.h, add explict
> include of mach/gpio.h.
I'm going to drop it for 3.7 too

the attached patch will do the same but in a more simpler way

Best Regards,
J.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-arm-at91-move-old-style-gpio-and-mux-to-arch-arm-mac.patch
Type: text/x-diff
Size: 10441 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120830/3ada4f76/attachment-0001.bin>
