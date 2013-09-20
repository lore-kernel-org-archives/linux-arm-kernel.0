From: kaloz@openwrt.org (Imre Kaloz)
Date: Fri, 20 Sep 2013 11:13:39 +0200
Subject: [PATCH] IXP4xx: Add Gateworks Cambria support.
In-Reply-To: <m37gebanth.fsf@t19.piap.pl>
References: <m3vc1ya9fw.fsf@t19.piap.pl> <op.w3oex8sc2s3iss@ecaz>
 <m37gebanth.fsf@t19.piap.pl>
Message-ID: <op.w3pc81032s3iss@ecaz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 20 Sep 2013 10:40:10 +0200, Krzysztof Ha?asa <khalasa@piap.pl> wrote:

> "Imre Kaloz" <kaloz@openwrt.org> writes:
>
>> This file seems to miss both the copyright from the code it's based on
>> as well as most of the additional support that one has.
>> So what's the point?
>
> I have the smaller Cambria (GW2350), not the bigger one which is also
> supported by OpenWRT. I'm not going to blindly pick up the OpenWRT code
> for which I don't have the hw and which I can't really test nor
> maintain.

So you delete portions of the code because you don't want to ask someone with the board to test your changes if needed, but given quite some people use the code for quite some time, you can also assume it works for them.

> The file contains information that it's partially based on OpenWRT, is it
> now a bad idea to pick up fragments from one GPLv2 project (OpenWRT) and
> include them in another GPLv2 project (Linux kernel)? Isn't it what
> OpenWRT does (in the opposite direction)? Aren't all the boards (in this
> particular case) based on Avila and IXDP425, the devel platform?

OpenWrt (yeah, we spell it this way for about 10 years now) is a Linux distribution, you do mix things up a bit here.

> The code doesn't carry any copyright headers maybe because in my country
> they aren't required, maybe because it's a trivial board support code
> which is mostly a list of devices and I didn't bother, and it doesn't
> have OpenWRT copyright because it's not a version from OpenWRT (while
> its parts are, as prominently stated). For precisely the same reason I
> list myself as the platform maintainer, I don't feel authorized to put
> somebody else here.

It's up to you if you add your copyright, but removing others' is clearly a different story legally. And I bet that's the same in your country, too.

> But I have an idea. I would be pleased if you submit and maintain (in
> the official Linux, not OpenWRT) your own version instead. It would be
> great if you also include Ubiquity RouterStation Pro (ATH79) and
> Gateworks Laguna (CNS3xxx). Those boards are supported for a long time
> by OpenWRT (at least there is support code there) and I'm personally
> using them with (stock) Linux.

I'll do when I'll get around it. Both others and we've pushed a lot of code upstream. In the meantime, anyone is free to do so, including you - dumbing down the code could be justifiable in some cases (I don't think this one applies), but dropping others' copyright -- hardly.


Imre
