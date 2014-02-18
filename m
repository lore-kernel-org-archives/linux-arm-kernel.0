From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 18 Feb 2014 19:43:27 +0100
Subject: [PATCH V3 11/17] i2c: nomadik: Convert to devm functions
In-Reply-To: <CAPDyKFpRaAAer00dqcXR-qOT9S8-SDTnaMUHRwWCZ93w-wnTDA@mail.gmail.com>
References: <1392650418-14820-1-git-send-email-ulf.hansson@linaro.org>
 <20140218110109.GA18768@katana>
 <CAPDyKFpRaAAer00dqcXR-qOT9S8-SDTnaMUHRwWCZ93w-wnTDA@mail.gmail.com>
Message-ID: <20140218184327.GF18768@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> I added the IS_ERR, check as you suggested. That caused a rebase of
> the other patches as well.
> 
> Sorry if it was unclear.

No problem. I am about to apply all patches except 17 as you suggested.
It fails here, however, although I applied Linus' patch first. What
exactly is your base? Any chance to publish your branch?

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140218/a90a39ec/attachment.sig>
