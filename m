From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 9 Mar 2010 09:04:32 +0000
Subject: Query about Linux framebuffer implementation
In-Reply-To: <tencent_5C46336B55A649383B399B3C@qq.com>
References: <tencent_5C46336B55A649383B399B3C@qq.com>
Message-ID: <20100309090432.GA5691@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 09, 2010 at 03:58:40PM +0800, ??? wrote:
> Hi, all
> 
> driver/video/fbmem.c implement framebuffer as a char device, in read/write API of this char device file operations, WHY does we need to: 
> 1st:kmalloc a space
> 2st:copy data between video memory buffer and kmalloced space above
> 3rd:copy kmalloced space data to/from user space buffer
> 
> why the hell we just copy data between video memory and user space buffer?

=> framebuffer mailing list (though that seems rather dead), maybe
lkml instead?
