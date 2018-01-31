From: ssuloev@orpaltech.com (Sergey Suloev)
Date: Wed, 31 Jan 2018 20:42:01 +0300
Subject: About testing A64 DE2 patches
Message-ID: <41ed8d45-d8a1-303b-dd1f-ad6686a60ba5@orpaltech.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, kernel people,

I am testing A64 DE2 patches from the list below, series v4, with my 
NanoPi A64 and 4.15

https://patchwork.kernel.org/project/linux-arm-kernel/list/?submitter=173461&page=1

and I'm getting the following issue regarding SRAM:

sunxi-de2-clks 1000000.clock: Error couldn't map SRAM to device

Here is my full dmesg https://pastebin.com/SQvDfJF0

Thanks
