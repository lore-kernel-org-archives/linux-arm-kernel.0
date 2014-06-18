From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 18 Jun 2014 16:59:22 +0100
Subject: Dove DT and HDMI on v3.16-rc1
In-Reply-To: <53A1B29C.6000604@gmail.com>
References: <535E079B.6010701@gmail.com> <20140428083144.GB6650@lunn.ch>
 <535F6DAF.1010400@gmail.com> <20140615152554.GA13870@n2100.arm.linux.org.uk>
 <53A19DFA.7030207@gmail.com> <20140618143447.GA22890@arch.cereza>
 <20140618150103.GE32514@n2100.arm.linux.org.uk> <53A1ABE8.8050401@gmail.com>
 <20140618153028.GF32514@n2100.arm.linux.org.uk> <53A1B29C.6000604@gmail.com>
Message-ID: <20140618155922.GG32514@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 18, 2014 at 05:39:08PM +0200, Sebastian Hesselbarth wrote:
> On 06/18/2014 05:30 PM, Russell King - ARM Linux wrote:
>> On Wed, Jun 18, 2014 at 05:10:32PM +0200, Sebastian Hesselbarth wrote:
>>> xf86-video-armada needs some missing
>>> #include "picturestr.h"
>>> for raring, but whole process has been very straight forward.
>>
>> I'm only aware of this (sorry, copy'n'pasted) which I found when trying
>> to build against ubuntu 14.04.  If further patches are needed to make it
>> compatible with more Xorg versions, please ensure that they find their
>> way into my inbox...
>
> Your patch also makes the xorg driver build fine on raring.
> When I encountered the build error, I just tried the first hit on Google
> - I didn't investigate it at all.

Thanks, just pushed that change out.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
