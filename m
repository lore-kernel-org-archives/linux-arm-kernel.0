From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 10 Feb 2016 16:24:38 +0100
Subject: EMXX platform support
In-Reply-To: <20160209201743.GA5628@reno.home>
References: <20160209201743.GA5628@reno.home>
Message-ID: <56882101.BaoQy5A3Ep@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 09 February 2016 21:17:44 Martin Langer wrote:
> Hello,
> 
> are there any plans in supporting emxx platform?
> 
> The Sony PCM D-100 is based on this platform and they released a lot of their linux code:
> http://oss.sony.net/Products/Linux/Audio/PCM-D100.html
> 
> ... including basic code for the kernel 2.6.35, see:
> http://oss.sony.net/Products/Linux/Audio/Download/PCM-D100/linux-kernel-2.6.35.tgz
> 
> I'm wondering that it is not yet part of the kernel. Probably I am the first person who looked into their package.
> 

You are welcome to start contributing a port, but please be aware that
platform support has been almost completely changed since 2.6.35, so
if you want to add something here, that likely involves a rewrite of
anything under arch/arm.

	Arnd
