From: balbi@ti.com (Felipe Balbi)
Date: Tue, 10 Dec 2013 10:32:20 -0600
Subject: [PATCH v3 07/15] mfd: menelaus: Limit the usage of the_menelaus
In-Reply-To: <20131210085701.GP12675@lee--X1>
References: <20131209161422.GC24047@saruman.home>
 <1386606085-26838-1-git-send-email-balbi@ti.com>
 <1386606085-26838-7-git-send-email-balbi@ti.com>
 <20131210085701.GP12675@lee--X1>
Message-ID: <20131210163220.GE22750@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 10, 2013 at 08:57:01AM +0000, Lee Jones wrote:
> > Pass a menelaus_chip pointer as argument to most functions so we can
> > minimize the usage of the global the_menelaus pointer.
> > 
> > Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > ---
> >  drivers/mfd/menelaus.c | 265 ++++++++++++++++++++++++++-----------------------
> >  1 file changed, 142 insertions(+), 123 deletions(-)
> 
> How is this different from patch 6?

have you read the patch ? patch 6 converts *only* enable/disable irq
functions.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131210/07a67e99/attachment.sig>
