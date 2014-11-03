From: broonie@kernel.org (Mark Brown)
Date: Mon, 3 Nov 2014 12:29:48 +0000
Subject: [PATCH 2/2] regulator: of: Add support for parsing microvolts
 for suspend state
In-Reply-To: <54549EA6.5060007@collabora.co.uk>
References: <1414813978-32233-1-git-send-email-dianders@chromium.org>
 <1414813978-32233-2-git-send-email-dianders@chromium.org>
 <54549EA6.5060007@collabora.co.uk>
Message-ID: <20141103122948.GI3815@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 01, 2014 at 09:49:42AM +0100, Javier Martinez Canillas wrote:
> On 11/01/2014 04:52 AM, Doug Anderson wrote:

> > +
> >  		of_node_put(suspend_np);
> >  		suspend_state = NULL;
> >  		suspend_np = NULL;

> Looks good to me.

> Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

If you're reviewing something please don't quote the entire patch, the
same rule applies as always - just include relevant context - and
especially don't include your one line of content at the very end of the
patch.  Otherwise people have to page through the entire thing to find
what you've said (if they don't get fed up first).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141103/a691f5e7/attachment.sig>
