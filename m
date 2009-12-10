From: mkl0301@hotmail.com (mkl lin)
Date: Thu, 10 Dec 2009 18:30:51 +0000
Subject: dma_cache_maint_contiguous should be patched asdma_cache_maint do
In-Reply-To: <1260465343.23073.63.camel@pc1117.cambridge.arm.com>
References: <SNT109-W4788A2C238168B3B9086CBA78D0@phx.gbl>,
	<1260459307.23073.41.camel@pc1117.cambridge.arm.com>,
	<20091210163920.GA13210@n2100.arm.linux.org.uk>,
	<1260465343.23073.63.camel@pc1117.cambridge.arm.com>
Message-ID: <SNT109-W37C0C3102A87E2E5BFCC2A78D0@phx.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> Good point, that's actually a quick modification (2-3 lines in each
> cache function). Mac Lin, can you try the patch below (without the other
> broadcasting patch)? If it works, I'll add some comment:
I have tested with my patch, and it seems good. No data integrity issue, nor any deadlock.

Best Regards,
Mac Lin
 		 	   		  
_________________________________________________________________
Windows Live: Friends get your Flickr, Yelp, and Digg updates when they e-mail you.
http://www.microsoft.com/middleeast/windows/windowslive/see-it-in-action/social-network-basics.aspx?ocid=PID23461::T:WLMTAGL:ON:WL:en-xm:SI_SB_3:092010
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smp.c.patch
Type: application/octet-stream
Size: 1159 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091210/aed3f989/attachment-0001.obj>
