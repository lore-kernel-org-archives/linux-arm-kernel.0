From: marex@denx.de (Marek Vasut)
Date: Sat, 22 Jun 2013 04:23:32 +0200
Subject: [PATCH v1 05/12] input: matrix-keypad: update comments,
 diagnostics
In-Reply-To: <1371838198-7327-6-git-send-email-gsi@denx.de>
References: <1371838198-7327-1-git-send-email-gsi@denx.de>
 <1371838198-7327-6-git-send-email-gsi@denx.de>
Message-ID: <201306220423.32625.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Gerhard Sittig,

> - add comments about individual routines' purpose and their interaction,
>   pre-conditions and consequences
> - mark a few spots which may need some more attention or clarification
> - rephrase some diagnostics messages
> 
> Signed-off-by: Gerhard Sittig <gsi@denx.de>
> ---
>  drivers/input/keyboard/matrix_keypad.c |   81
> +++++++++++++++++++++++++++++--- drivers/input/matrix-keymap.c          | 
>   4 +-
>  include/linux/input/matrix_keypad.h    |   17 ++++---
>  3 files changed, 89 insertions(+), 13 deletions(-)
> 

You might want to use kerneldoc for this , see Documentation/kernel-doc-nano-
HOWTO.txt

Best regards,
Marek Vasut
