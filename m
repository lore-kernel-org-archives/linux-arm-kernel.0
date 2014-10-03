From: broonie@kernel.org (Mark Brown)
Date: Fri, 3 Oct 2014 16:08:07 +0100
Subject: [PATCH v4 4/4] ASoC: tlv320aic3x: fix PLL D configuration
In-Reply-To: <1412342336-25700-5-git-send-email-d.lavnikevich@sam-solutions.com>
References: <1410854903-26419-1-git-send-email-d.lavnikevich@sam-solutions.com>
 <1412342336-25700-1-git-send-email-d.lavnikevich@sam-solutions.com>
 <1412342336-25700-5-git-send-email-d.lavnikevich@sam-solutions.com>
Message-ID: <20141003150807.GD24441@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 03, 2014 at 04:18:56PM +0300, Dmitry Lavnikevich wrote:
> Current caching implementation during regcache_sync() call bypasses
> all register writes of values that are already known as default
> (regmap reg_defaults). Same time in TLV320AIC3x codecs register 5

Applied, thanks.  This should really have been sent separately to the
other patches - it's not in any way specific to the board and there's no
dependency in either direction.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141003/ad58b3ed/attachment.sig>
