From: holler@ahsoftware.de (Alexander Holler)
Date: Wed, 02 Apr 2014 01:28:46 +0200
Subject: [PATCH] arm: don't allow CONFIG_DEBUG_SET_MODULE_RONX if
 CONFIG_JUMP_LABEL is enabled
In-Reply-To: <CAH+eYFDkYczZXYF3be6tTRg7kkGhK2zyukDTo+N8mwEKcG89LA@mail.gmail.com>
References: <1396346657-7166-1-git-send-email-holler@ahsoftware.de>
 <533AFF77.5030106@codeaurora.org>
 <CAGXu5jKMF9n9svQBhyQFvCoUe86QhLycDTt-fWyiRfySbn=Fug@mail.gmail.com>
 <CAH+eYFDkYczZXYF3be6tTRg7kkGhK2zyukDTo+N8mwEKcG89LA@mail.gmail.com>
Message-ID: <533B4BAE.5070905@ahsoftware.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 02.04.2014 01:08, schrieb Rabin Vincent:

> +void set_kernel_text_rw(struct mm_struct *mm)

(...)

> +void set_kernel_text_ro(struct mm_struct *mm)

(...)


Hmm, maybe such is doable for jump labels too. But I definitely can't 
discuss on that topic further through missing knowledge. ;)

Regards,

Alexander Holler
