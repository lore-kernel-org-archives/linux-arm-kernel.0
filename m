From: viriketo@gmail.com (=?UTF-8?Q?Llu=C3=ADs_Batlle?=)
Date: Wed, 23 Sep 2009 11:47:52 +0200
Subject: Problem in USB on the Sheevaplug, 2.6.31
In-Reply-To: <20090923093543.GJ2558@darwin>
References: <45219fb00909230143h38db71e7l7c16b4a59ec1b152@mail.gmail.com>
	<20090923093543.GJ2558@darwin>
Message-ID: <45219fb00909230247s65883755ia584b2e1e8c2369c@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Matthias,
glad to find you here. :)

2009/9/23, Matthias Kaehlcke <matthias@kaehlcke.net>:
> hi lluis,
>
> the USB FAQ suggests it might be a problem of signal quality, try if it
>  works when removing ehci-hcd:
>  http://www.linux-usb.org/FAQ.html#ts6
I have no cable between the board USB connector and the stick, and the
Sheevaplug people claim to have good USB 2.0 support... I will see if
it happens again.

>  is the file system subject to a lot of write accesses? in this case it
Yes, I'm using it as /tmp, where I do builds. Kernel builds for example.
>  is likely you will encounter problems of corrupt sectors due to flash
>  wear out. be sure not to mount locations like /var (especially
I barely used that stick... and I trust Kingston so I think this is
not the case.
>  /var/log) on the flash device. you also should mount the device with
>  the options noatime and nodiratime if you aren't doing it yet
I use noatime, but I didn't know of nodiratime.
>
>  <ca>per cert: que tal el sheeva plug? porto temps pensant de
>  comprar-ne un</ca>
<ca>Doncs n'estic ben content. Pel preu crec que est? molt b?. Hi he
estat portant el NixOS, i no he fet cap compilaci? creuada, aix? que
s'ho ha menjat tot el Sheevaplug. Per? fa nom?s un dia que utilitzo
l'stick USB, abans ho feia tot amb nfsroot.</ca>

Salutacions,
Llu?s.
