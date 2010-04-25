From: nico@fluxnic.net (Nicolas Pitre)
Date: Sun, 25 Apr 2010 10:13:54 -0400 (EDT)
Subject: [PATCH] ARM: fix highmem with VIPT cache and DMA
In-Reply-To: <315970.20396.qm@web35302.mail.mud.yahoo.com>
References: <315970.20396.qm@web35302.mail.mud.yahoo.com>
Message-ID: <alpine.LFD.2.00.1004251012250.7232@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 22 Apr 2010, Allen Pais wrote:

> Nicolas,
> 
>    As mentioned by Hemanth, we were facing issues with 
> highmem and MMC, but this is resolved now with the patch
> you shared. 
> 
>    Here's the patch for your ref.[its reverted cause of the
> issue] 
> http://dev.omapzoom.org/?p=integration/kernel-omap3.git;a=commit;h=f6427e74a3c08fa5e30c99de0e9e8ed9d3b65b74
> 
>   But currently we are facing issues with test cases such
> as AV Playback, mp3 play, image capture, camera 
> capture+mpeg4 encode. 
> 
>   Am not sure what's causing this break, any pointer would be
> helpful.

To be clear, are you saying that those test cases are failing with 
highmem only?


Nicolas
