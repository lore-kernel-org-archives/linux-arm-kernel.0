From: monstr@monstr.eu (Michal Simek)
Date: Mon, 18 Jun 2012 13:30:03 +0200
Subject: ARM SMP/GIC/LDS patches for Xilinx Zynq remoteproc
Message-ID: <1340019011-18642-1-git-send-email-monstr@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I am sending bunch of patches which I have made for a Xilinx Zynq remoteproc AMP solution +
some patches around.

Xilinx Zynq is dual core ARM Cortex A9. Remoteproc in new interface for controlling other cpus
is the system. I have created solution where on one ARM runs Linux and the second ARM
runs RTOS or any other standalone firmware. It is AMP between two ARM cores.

Communication is done via shared memory with kicking via IPI interrupts. 
Based on that I had to do some changes in the kernel which I am sending. 

Thanks for your review,
Michal
