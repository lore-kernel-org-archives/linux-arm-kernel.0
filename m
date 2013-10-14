From: liuj97@gmail.com (Jiang Liu)
Date: Mon, 14 Oct 2013 23:57:29 +0800
Subject: [PATCH v2 0/7] Optimize jump label implementation on ARM64
In-Reply-To: <20131014154044.GR25034@n2100.arm.linux.org.uk>
References: <1381675827-1610-1-git-send-email-liuj97@gmail.com>
 <20131014154044.GR25034@n2100.arm.linux.org.uk>
Message-ID: <525C1469.4000906@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/14/2013 11:40 PM, Russell King - ARM Linux wrote:
> On Sun, Oct 13, 2013 at 10:50:20PM +0800, Jiang Liu wrote:
>> To enable this feature, your toolchain must support "asm goto" extension
>> and "%c" constraint extesion. Current GCC for AARCH64 doesn't support
>> "%c", so you need a GCC patch similiar to this:
> 
> Oh god, not that again.  I've no idea why ARM stuff has such a problem with
> supporting this very useful "%c" GCC constraint.  Aarch32 didn't for ages
> consequently we now have horrid hacks around it in the kernel source
> because our compilers suck.  Seems Aarch64 is doomed to repeat the same
> stupid mistakes. :(
> 
We need to do the same trick for ARM64 too:)
