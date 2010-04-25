From: allenpais777@yahoo.com (Allen Pais)
Date: Sun, 25 Apr 2010 12:01:21 -0700 (PDT)
Subject: [PATCH] ARM: fix highmem with VIPT cache and DMA
In-Reply-To: <alpine.LFD.2.00.1004251012250.7232@xanadu.home>
Message-ID: <600365.21352.qm@web35301.mail.mud.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> 
>? ? As mentioned by Hemanth, we were facing issues with 
> highmem and MMC, but this is resolved now with the patch
> you shared. 
> 
>? ? Here's the patch for your ref.[its reverted cause of the
> issue] 
> http://dev.omapzoom.org/?p=integration/kernel-omap3.git;a=commit;h=f6427e74a3c08fa5e30c99de0e9e8ed9d3b65b74
> 
>???But currently we are facing issues with test cases such
> as AV Playback, mp3 play, image capture, camera 
> capture+mpeg4 encode. 
> 
>???Am not sure what's causing this break, any pointer would be
> helpful.

To be clear, are you saying that those test cases are failing with 
highmem only?

[Allen] Yes, when Highmem is enabled, these(testcases) failures
are what we are observing.

- Allen




      
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100425/6c4d9465/attachment-0001.htm>
