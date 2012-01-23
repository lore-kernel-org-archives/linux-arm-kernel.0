From: jdzheng@broadcom.com (Jiandong Zheng)
Date: Mon, 23 Jan 2012 12:37:53 -0800
Subject: [PATCH] arm: fix build failure in code for
 mach-bcmring/dma.c
In-Reply-To: <20120123201857.GA1068@n2100.arm.linux.org.uk>
References: <1327266579-21951-1-git-send-email-paul.gortmaker@windriver.com>
 <20120122211723.GB12326@n2100.arm.linux.org.uk>
 <4F1DACA7.1030501@broadcom.com>
 <20120123201857.GA1068@n2100.arm.linux.org.uk>
Message-ID: <4F1DC521.9020806@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Moreover, from what I can see, dma.c is unused by code in the mainline
> kernel - I couldn't find any reference to dma_map_mem() or
> dma_init_mem_map() both of which seem to be pre-requisits for using
> this code.  Obviously you have drivers which use it.
>
> What can be done to clean this up?
>
Yes, it was used by another driver not in mainline kernel. Since that 
driver is being rewritten and these functions are not used in mainline 
kernel either, I will send out a patch to remove them soon.

Thanks,
JD
