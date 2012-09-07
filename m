From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 06 Sep 2012 19:38:11 -0600
Subject: [PATCH] ARM: add support for BCM2708/BCM2835 and Raspberry Pi
In-Reply-To: <CAG-w=x77y6ykh3FcyTtVAN85eOk1RP2CZ=ZG-_1091i5jYDF2A@mail.gmail.com>
References: <1346908038-22421-1-git-send-email-swarren@wwwdotorg.org>
 <CAG-w=x77y6ykh3FcyTtVAN85eOk1RP2CZ=ZG-_1091i5jYDF2A@mail.gmail.com>
Message-ID: <50495003.500@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/06/2012 10:53 AM, Seth Jennings wrote:
> (sorry for the dup Stephen, forgot to reply all :-/)
> 
> On Thu, Sep 6, 2012 at 12:07 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>>
>> The BCM2708 is an ARM SoC from Broadcom. It is the primary SoC in a
>> series which contains the BCM2835 amongst other variants. This patch
>> adds very basic support for this series of SoCs, under the BCM2708 name.
> 
> Great work! I'm glad to see this heading upstream :)
> 
>> This series was extracted from git://github.com/lp0/linux.git branch
>> rpi-next or rpi-linear from 3-4 months ago, and significantly stripped
>> down and modified since.
> 
> I've used Simon's tree before and it will boot up all the way with UART
> support (no graphics, usb, network).  I also think it has a fully
> populated device
> tree.  Why, in particular, did you strip it down?

Mainly because not stripping it down would be a huge patch or set of
patches to review at once. The smaller and more basic we start, the
easier it is to get reviewed/applied etc., and then build on incrementally.
