From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
Date: Tue, 08 Sep 2015 13:06:00 +0200
Subject: I.MX6 HDMI support in v4.2
In-Reply-To: <1441709778.13536.8.camel@pengutronix.de> (Lucas Stach's message
 of "Tue, 08 Sep 2015 12:56:18 +0200")
References: <m3bnde5whx.fsf@t19.piap.pl>
 <20150907112555.GS21084@n2100.arm.linux.org.uk>
 <m337yp5gvv.fsf@t19.piap.pl> <1441709778.13536.8.camel@pengutronix.de>
Message-ID: <m3twr541d3.fsf@t19.piap.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lucas Stach <l.stach@pengutronix.de> writes:

>>  [drm:etnaviv_ioctl_gem_submit [etnaviv]] *ERROR* cmdstream bo has flag ETNA_BO_CMDSTREAM not set
>> and it doesn't work. I assume I shouldn't use it yet?
>> 
> You need changes to the X.Org driver for that to work. I'm currently
> working on a new version of the etnaviv-drm driver which will break the
> kernel userspace interface another time - hopefully for the last time
> now.
>
> I'm almost done and will publish patches for both the kernel and the
> X.Org driver today.

Great, I'm looking forward to be the first guinea pig :-)
Thanks.
-- 
Krzysztof Halasa

Industrial Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland
