From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 12 Apr 2016 17:36:09 +0200
Subject: [PATCH 3/6] ARM: PSCI: Register with kernel restart handler
In-Reply-To: <1460120039-2497-4-git-send-email-linux@roeck-us.net>
References: <1460120039-2497-1-git-send-email-linux@roeck-us.net>
 <1460120039-2497-4-git-send-email-linux@roeck-us.net>
Message-ID: <20160412153609.GA1537@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> +static int psci_sys_reset(struct notifier_block *np, unsigned long action,

Minor: notifier_block *nb instead of *np

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160412/0167d42a/attachment.sig>
