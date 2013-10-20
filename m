From: broonie@kernel.org (Mark Brown)
Date: Sun, 20 Oct 2013 17:29:45 +0100
Subject: [PATCH RESEND] ASoC: kirkwood: prefer external clock over
 internal clock
In-Reply-To: <20131018203452.177f8693@armhf>
References: <20131018203452.177f8693@armhf>
Message-ID: <20131020162945.GM2443@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 18, 2013 at 08:34:52PM +0200, Jean-Francois Moine wrote:
> When there is an external clock, always use this one.
> This prevents the two Dove audio devices to use the same DCO clock
> at different rates.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131020/b17dabc8/attachment.sig>
