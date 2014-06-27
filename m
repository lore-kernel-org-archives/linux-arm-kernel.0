From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Fri, 27 Jun 2014 19:36:12 +0200
Subject: [GIT PULL] ARM: mvebu: DT changes for v3.17
In-Reply-To: <D0DC98AD-E460-42C9-B2F4-51EDDE371E31@lakedaemon.net>
References: <20140627130129.GH23978@titan.lakedaemon.net>
 <20140627130430.GH32514@n2100.arm.linux.org.uk> <53AD724D.4020704@gmail.com>
 <20140627133933.GJ23978@titan.lakedaemon.net> <53AD7544.2060701@gmail.com>
 <D0DC98AD-E460-42C9-B2F4-51EDDE371E31@lakedaemon.net>
Message-ID: <53ADAB8C.6070609@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/27/2014 06:49 PM, Jason Cooper wrote:
>> On Jun 27, 2014, at 9:44, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com> wrote:
> ...
>> And I am not sure, if we want to rely on some six numbers stored on
>> SPI flash, i.e. there is no magic nor header to be really sure, it
>> is a MAC address.
> 
> It couldn't be compared with the MAC address of the nic?

Sure, but if it is not equal it tells you nothing.

You can change the NICs MAC in your bootloader, it will be different
from the numbers you read from SPI, and some mechanism will assume you
just made your production version into ES.

We really want to introduce such a crutch?

Sebastian
