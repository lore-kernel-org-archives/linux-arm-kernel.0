From: broonie@kernel.org (Mark Brown)
Date: Tue, 10 Feb 2015 15:12:51 +0800
Subject: [PATCH v3] ASoC: atmel_ssc_dai: Allow more rates
In-Reply-To: <1423494505-3368-1-git-send-email-peda@lysator.liu.se>
References: <1423494505-3368-1-git-send-email-peda@lysator.liu.se>
Message-ID: <20150210071251.GJ2593@finisterre.sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 09, 2015 at 04:08:25PM +0100, Peter Rosin wrote:
> From: Peter Rosin <peda@axentia.se>
> 
> When the SSC acts as BCK master, use a ratnum rule to limit
> the rate instead of only doing the standard rates. When the SSC
> acts as BCK slave, allow any BCK frequency up to the SSC master
> clock, divided by either of 2, 3 or 6.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150210/9f182c48/attachment.sig>
