From: broonie@kernel.org (Mark Brown)
Date: Thu, 11 Jul 2013 12:11:44 +0100
Subject: [PATCH] ASoC: Samsung: Set RFS and BFS in slave mode
In-Reply-To: <1373526505-27115-2-git-send-email-padma.v@samsung.com>
References: <1373526505-27115-1-git-send-email-padma.v@samsung.com>
 <1373526505-27115-2-git-send-email-padma.v@samsung.com>
Message-ID: <20130711111144.GL24508@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 11, 2013 at 12:38:25PM +0530, Padmavathi Venna wrote:
> As per the User Manual, the RFS and BFS should be set in slave mode
> for correct operation.

Applied, thanks.  Since this is a fix it should have been the first
patch in the series - this allows fixes to be sent to 

> Reviewed-on: https://gerrit-int.chromium.org/37841

Including things like this isn't terribly helpful - this is the Chromium
internal system and nobody in the community can view the review.  A link
to a public system might be useful but a private one should be omitted.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130711/486b9d13/attachment.sig>
