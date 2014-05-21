From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 21 May 2014 09:52:51 +0200
Subject: [PATCH v4 1/2] i2c: sunxi: Change i2c compatibles
In-Reply-To: <1396270498-30703-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1396270498-30703-1-git-send-email-maxime.ripard@free-electrons.com>
 <1396270498-30703-2-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20140521075251.GA2708@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 31, 2014 at 02:54:57PM +0200, Maxime Ripard wrote:
> The Allwinner A10 compatibles were following a slightly different compatible
> patterns than the rest of the SoCs for historical reasons. Move to the other
> pattern for consistency across all Allwinner Socs.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

I still don't prefer the removal of the old binding, but as this has
been discussed:

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140521/40e54070/attachment.sig>
