From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
Date: Tue, 15 Sep 2015 18:57:34 +0200
Subject: I.MX6 HDMI support in v4.2
In-Reply-To: <1442332425.2637.16.camel@pengutronix.de> (Lucas Stach's message
 of "Tue, 15 Sep 2015 17:53:45 +0200")
References: <m3bnde5whx.fsf@t19.piap.pl>
 <20150907112555.GS21084@n2100.arm.linux.org.uk>
 <m337yp5gvv.fsf@t19.piap.pl> <1441709778.13536.8.camel@pengutronix.de>
 <m3bnd52y4s.fsf@t19.piap.pl> <1442332425.2637.16.camel@pengutronix.de>
Message-ID: <m3613b39j5.fsf@t19.piap.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lucas Stach <l.stach@pengutronix.de> writes:

>> Only unscaled video: no color (luminance is good but the color
>> components are green). The driver doesn't use color information.
>> I hope this is easily fixable.

> There were patches for that some weeks ago already, I would hope they
> got applied to some tree destinied for upstream. Will look at that and
> ping people if necessary.

Good, this probably resolves one of main problems.
-- 
Krzysztof Halasa

Industrial Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland
