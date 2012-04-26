From: tushar.behera@linaro.org (Tushar Behera)
Date: Thu, 26 Apr 2012 09:23:07 +0530
Subject: [PATCH 00/33] Use common macro to define resources
In-Reply-To: <20120425113521.GW24211@n2100.arm.linux.org.uk>
References: <1335327163-11794-1-git-send-email-tushar.behera@linaro.org>
 <201204250938.58397.heiko@sntech.de>
 <20120425101007.GM9142@game.jcrosoft.org> <201204251121.47358.arnd@arndb.de>
 <20120425113521.GW24211@n2100.arm.linux.org.uk>
Message-ID: <4F98C6A3.1060700@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/25/2012 05:05 PM, Russell King - ARM Linux wrote:
> On Wed, Apr 25, 2012 at 11:21:47AM +0000, Arnd Bergmann wrote:
>> Note that the point of the DEFINE_RES_*() macros is really to prevent
>> people from coming up with new silly macros to do the same thing, as
>> we've had in the past.
> 
> One of the other reaons was to stop the stream of resources with wrong
> endings (because people kept thinking it was exclusive rather than
> inclusive) - and the resulting stream of additional patches to fix those
> errors.
> 
Patch 16, 18, 24 seemed to touch that problem. It was fixed in patches
16 and 24. There was not much clarity regarding the situation in patch
18, so it was left as it was.

-- 
Tushar Behera
