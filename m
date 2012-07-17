From: ian.molton@codethink.co.uk (Ian Molton)
Date: Tue, 17 Jul 2012 15:55:14 +0100
Subject: Device tree.
In-Reply-To: <13863985.aH2icoQzEI@flexo>
References: <500552C9.4090107@codethink.co.uk> <50056E22.5040308@gmail.com>
 <5b5e32ecde7b96d3af217054150eb43c@codethink.co.uk>
 <13863985.aH2icoQzEI@flexo>
Message-ID: <50057CD2.2060001@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/07/12 15:02, Florian Fainelli wrote:
> Depends on u-boot, the one we have been supplied doesn't seem to
> have any interest in booting zImages.
> In that case you just need to make sure that you produce a valid uImage of
> your zImage+dtb appended. This is what I use on old (1.1.6) uboot versions
> without any issues.

Thats what my little patch does. It just makes life a bit less painful 
if you're stuck with a particular bootloader. Its not an uncommon problem.

-Ian
