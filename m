From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 2 Mar 2018 12:08:06 +0100
Subject: [PATCH] i2c: s3c2410: Properly handle interrupts of number 0
In-Reply-To: <20180302110002.wmkvktobi7ssmin5@mwanda>
References: <1519936484-23132-1-git-send-email-krzk@kernel.org>
 <20180302102926.fuqmfyaxiujjwill@ninjato>
 <20180302110002.wmkvktobi7ssmin5@mwanda>
Message-ID: <20180302110806.naskbf5n7eiugsjd@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Wait, when did we decide that 12 wasn't enough?

I stand corrected. Sorry. I recall some discussion about using 14 and I
changed my git config according to that back then. I see now in
submitting patches that 12 is documented.

I will change my setting back. Sorry for the noise.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180302/3201d244/attachment.sig>
