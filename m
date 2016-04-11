From: Alexey.Brodkin@synopsys.com (Alexey Brodkin)
Date: Mon, 11 Apr 2016 17:31:47 +0000
Subject: [PATCH v2 02/30] Include generic parity.h in some
 architectures' bitops.h
In-Reply-To: <1459932086-6394-1-git-send-email-zengzhaoxiu@163.com>
References: <57033DBB.6060600@gmail.com>
 <1459932086-6394-1-git-send-email-zengzhaoxiu@163.com>
Message-ID: <1460395905.5119.43.camel@synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi?Zhaoxiu,

On Wed, 2016-04-06 at 16:41 +0800, zengzhaoxiu at 163.com wrote:
> From: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>
> 
> Use the generic version
> 
> Signed-off-by: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>
> ---
> ?arch/arc/include/asm/bitops.h??????| 1 +
> ?arch/arm/include/asm/bitops.h??????| 1 +
> ?arch/arm64/include/asm/bitops.h????| 1 +
> ?arch/avr32/include/asm/bitops.h????| 1 +
> ?arch/c6x/include/asm/bitops.h??????| 1 +
> ?arch/cris/include/asm/bitops.h?????| 1 +
> ?arch/frv/include/asm/bitops.h??????| 1 +
> ?arch/h8300/include/asm/bitops.h????| 1 +
> ?arch/hexagon/include/asm/bitops.h??| 1 +
> ?arch/m32r/include/asm/bitops.h?????| 1 +
> ?arch/m68k/include/asm/bitops.h?????| 1 +
> ?arch/metag/include/asm/bitops.h????| 1 +
> ?arch/mn10300/include/asm/bitops.h??| 1 +
> ?arch/openrisc/include/asm/bitops.h | 1 +
> ?arch/parisc/include/asm/bitops.h???| 1 +
> ?arch/s390/include/asm/bitops.h?????| 1 +
> ?arch/sh/include/asm/bitops.h???????| 1 +
> ?arch/xtensa/include/asm/bitops.h???| 1 +
> ?18 files changed, 18 insertions(+)

Could you please include a changelog below your commit message?
Otherwise it's barely possible to understand what that v2 improves/fixes.

Also it makes sense to send at least cover letter to all people mentioned
at least in one patch of the series. That gives an idea what this series
does and in particular why patch I'm mentioned in is required.

-Alexey
