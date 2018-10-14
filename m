From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 15 Oct 2018 00:33:11 +0200
Subject: [PATCH 0/2] mmc: uniphier-sd: two bug-fixes
In-Reply-To: <1539356258-12374-1-git-send-email-yamada.masahiro@socionext.com>
References: <1539356258-12374-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20181014223311.GE3260@kunai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> In further testing in uniphier-sd.c,
> I found my stupid mistakes.

I don't have the uniphier HW but I still had a look at these patches.
You never know if there is something interesting for SDHI in there :)

> Can you squash this series into
> 3fd784f745dd
> "mmc: uniphier-sd: add UniPhier SD/eMMC controller driver"
> if you have a chance to do rebase?

Please don't rebase! We actually develop on top of mmc/next and rebasing
creates a lot of pain because we lose the base for that work.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181015/8c912046/attachment.sig>
