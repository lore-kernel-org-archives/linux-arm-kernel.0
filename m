From: michael.opdenacker@free-electrons.com (Michael Opdenacker)
Date: Thu, 16 Feb 2012 12:05:19 +0100
Subject: [PATCH] ARM: boot/compressed/decompress.c cleanup
In-Reply-To: <20120216085010.GI13673@n2100.arm.linux.org.uk>
References: <1329370449-12033-1-git-send-email-michael.opdenacker@free-electrons.com>
 <20120216085010.GI13673@n2100.arm.linux.org.uk>
Message-ID: <4F3CE2EF.60709@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Thank you for reviewing my patch.

On 02/16/2012 09:50 AM, Russell King - ARM Linux wrote:
> On Thu, Feb 16, 2012 at 06:34:09AM +0100, Michael Opdenacker wrote:
>> - Remove the ARCH_HAS_DECOMP_WDOG define
>>   because it is only used in lib/deflate.c, which
>>   only the alpha architecture uses. No other architecture
>>   uses this define
> No.  Your grepping is broken.
Oops, my mistake. Actually, only arm uses this feature.

I'll soon post an updated patch.

Thanks again,

Michael.

-- 
Michael Opdenacker, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
+33 484 253 396
