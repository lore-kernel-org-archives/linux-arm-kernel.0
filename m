From: broonie@kernel.org (Mark Brown)
Date: Wed, 16 Aug 2017 11:59:54 +0100
Subject: [PATCH 2/9] ASoC: cygnus: Update bindings for audio clock changes
In-Reply-To: <d7e7144b-26c7-b96a-663d-03744bb60c36@broadcom.com>
References: <1502748417-26417-1-git-send-email-lori.hikichi@broadcom.com>
 <1502748417-26417-3-git-send-email-lori.hikichi@broadcom.com>
 <20170815171424.whcy4mftex6sgzgj@sirena.org.uk>
 <d7e7144b-26c7-b96a-663d-03744bb60c36@broadcom.com>
Message-ID: <20170816105954.ve434zeeqinweo5a@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 15, 2017 at 12:29:44PM -0700, Lori Hikichi wrote:

> I have put the mux assignment in DT because the assignment is a
> static property and did not need run time programmability from the
> machine driver.

Why is this a static property, what prevents something wanting to change
things at runtime?  You might be running with simpler setups now but
perhaps you'll run into a more complex use case later?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170816/98363145/attachment.sig>
