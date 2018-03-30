From: sebastian.reichel@collabora.co.uk (Sebastian Reichel)
Date: Fri, 30 Mar 2018 14:19:59 +0200
Subject: 4.16-rc5 on Motorola Droid 4
In-Reply-To: <20180327212156.GA10834@amd>
References: <20180318220418.GA22880@amd> <20180320140322.GU5799@atomide.com>
 <20180320170029.rv3u5wlvqxfl7z2v@earth.universe>
 <20180327212156.GA10834@amd>
Message-ID: <20180330121959.uxx6kcl7v5w777vq@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Mar 27, 2018 at 11:21:56PM +0200, Pavel Machek wrote:
> Also, if you know how to get information from light sensor, that would
> be nice.

You need CONFIG_SENSORS_ISL29028. Once the driver is probed:

$ cat /sys/bus/iio/devices/iio\:device1/name
isl29030
$ cat /sys/bus/iio/devices/iio\:device1/in_illuminance_input
19

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180330/88145bbf/attachment.sig>
