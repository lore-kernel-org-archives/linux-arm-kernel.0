From: vipulsamar87@gmail.com (vipul samar)
Date: Wed, 10 Nov 2010 14:35:09 +0530
Subject: Size of dma_alloc_writecombine.
Message-ID: <AANLkTi=287gpR8eeQH-p5ZHEW5GtFQoqHa-TA_-NW1ZN@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I am working on LCD module of resolution size 1024X768. When i am allocating
memory for frame buffer using dma_alloc_writecombine call its not able to
allocate memory more then 2MB memory. The Reason is the maximum size
allocated by  dma_alloc_writecombine is 2 MB.
Can i make changes in arm files and extend maximum size to 4MB?? or should i
go for other options??

Please suggest me the best way to allocate memory more then 2MB.

Regards
Vipul Samar
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101110/dbdaf020/attachment.html>
