From: broonie@kernel.org (Mark Brown)
Date: Mon, 21 Sep 2015 14:13:32 -0700
Subject: [PATCH v3 11/12] regulator: pwm: implement ->enable(),
 ->disable() and ->is_enabled methods
In-Reply-To: <1442828009-6241-12-git-send-email-boris.brezillon@free-electrons.com>
References: <1442828009-6241-1-git-send-email-boris.brezillon@free-electrons.com>
 <1442828009-6241-12-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20150921211332.GG30445@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 21, 2015 at 11:33:28AM +0200, Boris Brezillon wrote:

> Implement the ->enable(), ->disable() and ->is_enabled methods and remove
> the PWM call in ->set_voltage_sel().

I'll apply this so it definitely makes it into mainline, I'm happy to
provide a tag for this so it can be merged into the PWM tree if the rest
of the series is ready.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150921/ef277e6f/attachment.sig>
