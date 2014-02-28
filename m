From: broonie@kernel.org (Mark Brown)
Date: Fri, 28 Feb 2014 15:07:28 +0900
Subject: I2C dummy adapter driver ?
In-Reply-To: <53073C51.5010401@samsung.com>
References: <5305382E.9050902@gmail.com>
 <CAJe_ZhcMMVRTErH3ctbnZyn30_cp9XXjEfUZXdWaVWUHqs4CRw@mail.gmail.com>
 <53073C51.5010401@samsung.com>
Message-ID: <20140228060728.GB29849@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 21, 2014 at 12:45:21PM +0100, Sylwester Nawrocki wrote:

> The I2C bus driver with empty i2c_algorithm.master_xfer() helps WRT to
> using standard DT binding and v4l2_subdev interface.

Wouldn't a platform device do just as well here if there's no actual
control?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140228/376a4f72/attachment.sig>
