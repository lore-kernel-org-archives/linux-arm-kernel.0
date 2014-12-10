From: broonie@kernel.org (Mark Brown)
Date: Wed, 10 Dec 2014 23:53:47 +0000
Subject: [PATCH 1/4] regulator: core: Support trying to get close to a
 certain voltage
In-Reply-To: <1418245085-9754-1-git-send-email-dianders@chromium.org>
References: <1418245085-9754-1-git-send-email-dianders@chromium.org>
Message-ID: <20141210235347.GT11764@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 10, 2014 at 12:58:02PM -0800, Doug Anderson wrote:
> There are some cases where you'd like to set a voltage for a regulator
> and a range of voltages are OK, but you'd really like to get as close
> as you can to a specific voltage if at all possible.

This looks like regulator_set_voltage_tol(), why not use that?  The spec
probably even has a number for the tolerance, or you can make one up.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141210/ca87ca90/attachment.sig>
