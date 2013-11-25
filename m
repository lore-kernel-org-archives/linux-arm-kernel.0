From: broonie@kernel.org (Mark Brown)
Date: Mon, 25 Nov 2013 17:11:06 +0000
Subject: [PATCH RESEND] ASoC: clk: probe defer when clock not yet ready
In-Reply-To: <20131125093849.5fadc450@armhf>
References: <20131125093849.5fadc450@armhf>
Message-ID: <20131125171106.GJ14725@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 25, 2013 at 09:38:49AM +0100, Jean-Francois Moine wrote:
> At probe time, a clock device may not be ready when some other device
> wants to use it. 

The patch subject starts of "ASoC:" but this is a patch for the clock
API only (it does then say clk:) - you probably want to fix that, it's
not going to help get it noticed.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131125/8baff26a/attachment.sig>
