From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sun, 14 Apr 2013 19:26:25 +0200
Subject: [PATCH] ARM: KVM: Add missing break;
In-Reply-To: <1365918945.1878.8.camel@joe-AO722>
References: <1365917315-3615-1-git-send-email-linux@prisktech.co.nz>
 <1365918945.1878.8.camel@joe-AO722>
Message-ID: <d57c84379b08873899ad0bcf95848fa7@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joe,

On Sat, 13 Apr 2013 22:55:45 -0700, Joe Perches <joe@perches.com> wrote:
> commit 3401d54696f ("KVM: ARM: Introduce KVM_ARM_SET_DEVICE_ADDR ioctl")
> added the case, but omitted adding break;

[...]

Already reported here:
http://lists.infradead.org/pipermail/linux-arm-kernel/2013-April/160127.html

> $ grep -rP --include=*.[ch]
> "\b(\w+)\s*=[^;]+;\s*(?:case\s+\w+:|default:)\s*\1\s*="

Cool regexp! :-)
 
Cheers,

        M.
-- 
Fast, cheap, reliable. Pick two.
