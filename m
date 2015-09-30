From: broonie@kernel.org (Mark Brown)
Date: Wed, 30 Sep 2015 19:38:03 +0100
Subject: [PATCH 2/2] ASoC: sun4i-codec: Remove redundant SND_PCM_RATE_KNOT
In-Reply-To: <1443555798-16001-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1443555798-16001-1-git-send-email-maxime.ripard@free-electrons.com>
 <1443555798-16001-2-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20150930183803.GW15635@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 29, 2015 at 09:43:18PM +0200, Maxime Ripard wrote:
> The SND_PCM_RATE_KNOT covers all the rate settings, even though some that
> we don't support, while we also list all the rate we support. Simply remove
> it.

I'll apply this but ideally you'd be able to use _KNOT plus some
extra constraints registered in startup() for maximum flexability but
realistically people mostly only use the standard rates anyway.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150930/d4a491ca/attachment-0001.sig>
