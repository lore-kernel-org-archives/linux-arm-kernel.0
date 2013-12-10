From: balbi@ti.com (Felipe Balbi)
Date: Tue, 10 Dec 2013 10:32:49 -0600
Subject: [PATCH v3 08/15] mfd: menelaus: Pass menelaus_chip pointer to
 add/remove irq functions
In-Reply-To: <20131210090021.GQ12675@lee--X1>
References: <20131209161422.GC24047@saruman.home>
 <1386606085-26838-1-git-send-email-balbi@ti.com>
 <1386606085-26838-8-git-send-email-balbi@ti.com>
 <20131210090021.GQ12675@lee--X1>
Message-ID: <20131210163249.GF22750@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 10, 2013 at 09:00:21AM +0000, Lee Jones wrote:
> On Mon, 09 Dec 2013, Felipe Balbi wrote:
> 
> > Those functions are static and can receive a menelaus_chip pointer very
> > easily.
> > 
> > Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > ---
> >  drivers/mfd/menelaus.c | 57 ++++++++++++++++++++++++++------------------------
> >  1 file changed, 30 insertions(+), 27 deletions(-)
> 
> Same here. I think this should be done in one fell swoop.

then it would become a much, much larger patch which would become a pain
to review.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131210/7a409074/attachment.sig>
