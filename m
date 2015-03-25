From: Nathan_Lynch@mentor.com (Nathan Lynch)
Date: Wed, 25 Mar 2015 08:21:13 -0500
Subject: [PATCH v11 0/4] ARM: VDSO
In-Reply-To: <20150325101004.GX8656@n2100.arm.linux.org.uk>
References: <1426886003-30123-1-git-send-email-nathan_lynch@mentor.com>
 <20150325101004.GX8656@n2100.arm.linux.org.uk>
Message-ID: <5512B649.5050306@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/25/2015 05:10 AM, Russell King - ARM Linux wrote:
> On Fri, Mar 20, 2015 at 04:13:19PM -0500, Nathan Lynch wrote:
>> Provide fast userspace implementations of gettimeofday and
>> clock_gettime on systems that implement the generic timers extension
>> defined in ARMv7.  This follows the example of arm64 in conception but
>> significantly differs in some aspects of the implementation (C vs
>> assembly, mainly).
> 
> Okay, having re-read the code, I'm happy with this now.  I'll see about
> testing it out on the platforms I have here in the next few days.  As
> I now have a Cortex A15 platform, I can hopefully also check what effect
> it has there (assuming ethernet gets fixed on it so I can get programs
> onto the platform.)

Thanks Russell, I'll put it in the patch tracker today.

I'll follow up with a link to the glibc patch when I post that too.
