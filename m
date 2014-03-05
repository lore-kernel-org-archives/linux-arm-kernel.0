From: broonie@kernel.org (Mark Brown)
Date: Wed, 5 Mar 2014 12:26:02 +0800
Subject: [PATCH v2 02/11] drivercore: Bind/unbind power domain on
 probe/remove
In-Reply-To: <1393862536-9842-3-git-send-email-tomasz.figa@gmail.com>
References: <1393862536-9842-1-git-send-email-tomasz.figa@gmail.com>
 <1393862536-9842-3-git-send-email-tomasz.figa@gmail.com>
Message-ID: <20140305042602.GE13126@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 03, 2014 at 05:02:07PM +0100, Tomasz Figa wrote:
> On a number of platforms, devices are part of controllable power
> domains, which need to be enabled before such devices can be accessed
> and may be powered down when the device is idle to save some power.
> This means that on systems that support power domain control using
> generic power domains subsystem, it is necessary to add device to its
> power domain before binding a driver to it and remove it from its power
> domain after its driver is unbound to make sure that an unused device
> does not affect power domain state.

Reviewed-by: Mark Brown <broonie@linaro.org>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140305/1b9eb003/attachment.sig>
