From: 914059751@qq.com (=?gbk?B?uvrR7sr3?=)
Date: Tue, 9 Mar 2010 15:58:40 +0800
Subject: Query about Linux framebuffer implementation
Message-ID: <tencent_5C46336B55A649383B399B3C@qq.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, all

driver/video/fbmem.c implement framebuffer as a char device, in read/write API of this char device file operations, WHY does we need to: 
1st:kmalloc a space
2st:copy data between video memory buffer and kmalloced space above
3rd:copy kmalloced space data to/from user space buffer

why the hell we just copy data between video memory and user space buffer?


THX
ROCKY
