From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Fri, 27 Jun 2014 15:44:36 +0200
Subject: [GIT PULL] ARM: mvebu: DT changes for v3.17
In-Reply-To: <20140627133933.GJ23978@titan.lakedaemon.net>
References: <20140627130129.GH23978@titan.lakedaemon.net>
 <20140627130430.GH32514@n2100.arm.linux.org.uk> <53AD724D.4020704@gmail.com>
 <20140627133933.GJ23978@titan.lakedaemon.net>
Message-ID: <53AD7544.2060701@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/27/2014 03:39 PM, Jason Cooper wrote:
> On Fri, Jun 27, 2014 at 03:31:57PM +0200, Sebastian Hesselbarth wrote:
>> Also, production variants have their MAC address stored at 0xd0000 on
>> SPI flash. And while ES has PL2303 USB-to-UART, production use a
>> different brand, IIRC FTDI.
>
> Could you do a follow on patch adding a comment to this effect?  The
> Debian guys will need this for flash-kernel and friends.

I don't know if that information will be of any use at all.

You cannot determine USB-to-UART type from CuBox but your host PC only.

And I am not sure, if we want to rely on some six numbers stored on
SPI flash, i.e. there is no magic nor header to be really sure, it
is a MAC address.

Sebastian
