From: broonie@kernel.org (Mark Brown)
Date: Tue, 12 Apr 2016 05:42:03 +0100
Subject: [PATCH v5 30/46] regulator: pwm: retrieve correct voltage
In-Reply-To: <20160407235431.788dc24a@bbrezillon>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
 <1459368249-13241-31-git-send-email-boris.brezillon@free-electrons.com>
 <20160330212410.GX2350@sirena.org.uk>
 <20160407235431.788dc24a@bbrezillon>
Message-ID: <20160412044203.GW3351@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 07, 2016 at 11:54:31PM +0200, Boris Brezillon wrote:

> Is there any reason for calling set_machine_constraints() after
> device_register() in regulator_register()?

I'm not sure there's a strong one, we don't really use the class device
for anything, but without doing a full audit I couldn't guarantee that.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160412/fc8741d8/attachment.sig>
