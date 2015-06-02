From: broonie@kernel.org (Mark Brown)
Date: Tue, 2 Jun 2015 11:53:28 +0100
Subject: [PATCH 0/6] Support CPR on MSM8916
In-Reply-To: <1433209679-31389-1-git-send-email-sboyd@codeaurora.org>
References: <1433209679-31389-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <20150602105328.GJ14071@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 01, 2015 at 06:47:53PM -0700, Stephen Boyd wrote:

> Stephen Boyd (6):
>   regulator: core: Don't spew backtraces on duplicate sysfs
>   regulator: core: Print at debug level on debugfs creation failure

These two patches don't seem to be tied to the rest of the series at all
(they certainly trigger already for some systems).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150602/15cea945/attachment.sig>
