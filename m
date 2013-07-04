From: broonie@kernel.org (Mark Brown)
Date: Thu, 4 Jul 2013 10:00:49 +0100
Subject: SPI : DUAL/QUAD support
In-Reply-To: <CAHSAbzMGqQgCLL9ymQ6qSeJRybv2jJfm-sbzZVgayVyKYgufLQ@mail.gmail.com>
References: <CAHSAbzMGqQgCLL9ymQ6qSeJRybv2jJfm-sbzZVgayVyKYgufLQ@mail.gmail.com>
Message-ID: <20130704090049.GJ27646@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 04, 2013 at 03:07:31PM +0800, ??? wrote:

> Now some SPI controllers and Slave Devices have supported
> DUAL and QUAD transfer mode. But SPI controller driver in kernel
> has no member to deliver this information from Slave to Master.
> So in my opinion, adding transfer mode members to deal with the problem.

You'll need to tell us what "DUAL" and "QUAD" modes are and provide some
kerneldoc for the new fields.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130704/6b1f6dc6/attachment.sig>
