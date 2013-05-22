From: broonie@kernel.org (Mark Brown)
Date: Wed, 22 May 2013 14:05:18 -0500
Subject: [PATCH 7/9] I2C: mv64xxx: remove I2C_M_NOSTART code
In-Reply-To: <E1Ud4vH-0004Jz-F6@rmk-PC.arm.linux.org.uk>
References: <20130516202921.GW18614@n2100.arm.linux.org.uk>
 <E1Ud4vH-0004Jz-F6@rmk-PC.arm.linux.org.uk>
Message-ID: <20130522190518.GA1627@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 16, 2013 at 09:37:11PM +0100, Russell King wrote:

> As this driver does not advertise protocol mangling support
> (I2C_FUNC_PROTOCOL_MANGLING is not set), having code to act on
> I2C_M_NOSTART is illogical, and in any case isn't supportable on
> anything but the first message - which makes no sense.  Remove
> the I2C_M_NOSTART code.

There is I2C_FUNC_NOSTART, though if it's only possible to use it on the
first message that is pretty much useless as you say.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130522/ffffb826/attachment.sig>
