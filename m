From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 1 Nov 2013 23:13:28 +0100
Subject: Donation of Allwinner-based CubieTruck to anyone interested in
 developing & upstreaming
In-Reply-To: <CAOJ6w=FGjOrW5Ukzet4gsa4grkyZQei+OJfU4N_HqdKmaFjntw@mail.gmail.com>
References: <CAOJ6w=FGjOrW5Ukzet4gsa4grkyZQei+OJfU4N_HqdKmaFjntw@mail.gmail.com>
Message-ID: <20131101221328.GD26440@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexey,

On Fri, Nov 01, 2013 at 05:48:54PM +0200, Alexey Eromenko wrote:
> Hello,
> 
> My name is Alexey, and I'm interested in having ARM CubieTruck
> hardware well supported by Debian for desktop (KDE) use.
> 
> CubieTruck is an ARM mini-PC aka "Liliputer", based on AllWinner A20
> SoC + 2 GB RAM + 8 GB flash + VGA (!) port + SATA + Ethernet + WiFi,
> making it good enough for a real Debian desktop.
> 
> CubieTruck
> http://cubietruck.com/collections/frontpage/products/cubietruck-cubieboard3-cortex-a7-dual-core-2gb-ram-8gb-flash-with-wifi-bt
> 
> My goal: It should have a working 2D, HD Video and 3D graphics as well
> as audio and networking.
> 
> Some open-source drivers exist:
> *2D - xf86-video-fbturbo - link: https://github.com/ssvb/xf86-video-fbturbo
> *Hardware Video Decoder - "CedarX" link:
> http://linux-sunxi.org/Reverse_Engineering/Cedar_Status
> *3D - open-source Lima or closed-source Mali drivers.
> 
> WiFi + Bluetooth - status unknown. (WiFi firmware is probably closed source)
> 
> The problem is that the Allwinner Linux kernel is a fork of the real Linux 3.4.x
> If you can - please help mainline those patches & drivers and
> integrate them upstream.
> Additional involvement in docs + graphics drivers is welcome.
> 
> Worth reading: Getting Allwinner SoC support upstream:
> http://www.phoronix.com/scan.php?page=news_item&px=MTM4NDc
> 
> and here:
> http://lkml.indiana.edu/hypermail/linux/kernel/1306.0/02744.html

Both these links are spreading non-sense. There is already some
Allwinner support, there's nothing wrong with them, and the only issue
keeping them from gaining more support is people contributing (and
your initiative is very much welcome for that).

All the features mentionned are indeed not supported as of today, and
probably won't be in the near future unless someone shows up and does
the work. Access to some hardware isn't really an issue, only 24h-long
day are.

> I will donate few ARM CubieTruck samples to interested people. You'll
> need a proof of past patches to any open-source project or community
> involvement.

Thanks for this!
Now, let's hope that someone will be interested :)

Maxime
-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131101/11ed90ef/attachment.sig>
