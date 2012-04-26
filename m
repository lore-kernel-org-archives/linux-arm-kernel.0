From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Thu, 26 Apr 2012 17:27:51 -0500
Subject: [PATCH 04/17] ARM: ep93xx: use machine specific hook for late init
In-Reply-To: <20120426221222.GI24211@n2100.arm.linux.org.uk>
References: <1335454725-13089-1-git-send-email-shawn.guo@linaro.org>
 <1335454725-13089-5-git-send-email-shawn.guo@linaro.org>
 <4F99B9EB.6060806@gmail.com>
 <ADE657CA350FB648AAC2C43247A983F002069887EDC4@AUSP01VMBX24.collaborationhost.net>
 <20120426221222.GI24211@n2100.arm.linux.org.uk>
Message-ID: <ADE657CA350FB648AAC2C43247A983F002069887EDDE@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, April 26, 2012 3:12 PM, Russell King wrote:
> On Thu, Apr 26, 2012 at 04:49:27PM -0500, H Hartley Sweeten wrote:
>> Wouldn't every mach-* supported by a unified kernel have to at least
>> be the same ARM variant (i.e. they share a common compiler setup)?
>> The ep93xx is an arm920t. Are there any other mach-* types that use
>> that?
>
> ... which would be compatible with any kernel which includes ARMv4
> through to ARMv5t CPUs.  I've built for many many many years Integrator
> support with every CPU between ARM720T to ARM926T.

Thanks for the clarification!

Ryan,
Based on that I would assume that Shawn's patch is also relevant to ep93xx
to help with the unified kernel.

Regards,
Hartley
