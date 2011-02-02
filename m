From: lee.jones@canonical.com (Lee Jones)
Date: Wed, 02 Feb 2011 09:52:39 +0000
Subject: [PATCH] RFC: ux500: add PMU resources
In-Reply-To: <1295391579-9166-1-git-send-email-linus.walleij@stericsson.com>
References: <1295391579-9166-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <4D492967.4080303@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It sounds Will's timer idea would be the ideal solution in this case. As Will has previously mentioned, this would also help other venders who are experiencing buggy/non-existent PMU IRQs. I'd be happy to attempt coding this up. Although, to limit wastage of valuable time, I'd like to have the idea sanctioned by Russel et al prior to doing so.
