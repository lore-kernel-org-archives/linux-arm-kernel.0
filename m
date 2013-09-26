From: broonie@kernel.org (Mark Brown)
Date: Thu, 26 Sep 2013 11:24:08 +0100
Subject: [PATCH] ASoc: kirkwood: Extend the min and max number of bytes
 per period
In-Reply-To: <20130919112043.5ad16147@armhf>
References: <20130919112043.5ad16147@armhf>
Message-ID: <20130926102408.GE19304@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 19, 2013 at 11:20:43AM +0200, Jean-Francois Moine wrote:
> This patch extends the min and max number of bytes per period.
> It mainly permits to reduce the sound delay in MIDI real-time playing.

Applied, thanks.  For the minimum limit is there any hardware imposed
limit that could be used rather than tweaking the numbers?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130926/43ff31de/attachment.sig>
