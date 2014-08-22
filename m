From: broonie@kernel.org (Mark Brown)
Date: Thu, 21 Aug 2014 21:19:38 -0500
Subject: [PATCH] regulator: RK808: Fix uninitialized value
In-Reply-To: <1408668895-1108-1-git-send-email-dianders@chromium.org>
References: <1408668895-1108-1-git-send-email-dianders@chromium.org>
Message-ID: <20140822021938.GT24407@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 21, 2014 at 05:54:55PM -0700, Doug Anderson wrote:
> The RK808 regulator driver was putting its config on the stack but not
> initting it.  That means that you got a semi-random config.  Fix this.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140821/777cb340/attachment-0001.sig>
