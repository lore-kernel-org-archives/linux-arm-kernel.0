From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
Date: Fri, 20 Sep 2013 10:40:10 +0200
Subject: [PATCH] IXP4xx: Add Gateworks Cambria support.
In-Reply-To: <op.w3oex8sc2s3iss@ecaz> (Imre Kaloz's message of "Thu, 19 Sep
 2013 22:52:46 +0200")
References: <m3vc1ya9fw.fsf@t19.piap.pl> <op.w3oex8sc2s3iss@ecaz>
Message-ID: <m37gebanth.fsf@t19.piap.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Imre Kaloz" <kaloz@openwrt.org> writes:

> This file seems to miss both the copyright from the code it's based on
> as well as most of the additional support that one has.
> So what's the point?

I have the smaller Cambria (GW2350), not the bigger one which is also
supported by OpenWRT. I'm not going to blindly pick up the OpenWRT code
for which I don't have the hw and which I can't really test nor
maintain.
The file contains information that it's partially based on OpenWRT, is it
now a bad idea to pick up fragments from one GPLv2 project (OpenWRT) and
include them in another GPLv2 project (Linux kernel)? Isn't it what
OpenWRT does (in the opposite direction)? Aren't all the boards (in this
particular case) based on Avila and IXDP425, the devel platform?

The code doesn't carry any copyright headers maybe because in my country
they aren't required, maybe because it's a trivial board support code
which is mostly a list of devices and I didn't bother, and it doesn't
have OpenWRT copyright because it's not a version from OpenWRT (while
its parts are, as prominently stated). For precisely the same reason I
list myself as the platform maintainer, I don't feel authorized to put
somebody else here.

But I have an idea. I would be pleased if you submit and maintain (in
the official Linux, not OpenWRT) your own version instead. It would be
great if you also include Ubiquity RouterStation Pro (ATH79) and
Gateworks Laguna (CNS3xxx). Those boards are supported for a long time
by OpenWRT (at least there is support code there) and I'm personally
using them with (stock) Linux.
-- 
Krzysztof Halasa

Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland
