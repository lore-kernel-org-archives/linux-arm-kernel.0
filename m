From: mkl0301@hotmail.com (mkl lin)
Date: Mon, 7 Dec 2009 03:13:32 +0000
Subject: dma_cache_maint_contiguous should be patched as dma_cache_maint do
Message-ID: <SNT109-W5018A3A559755D12BA4C73A7900@phx.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


hi,

I'm new to this ML and kernel hacking, so please correct me if I'm wrong.

I had had an issue on USB data read, which is often incorrect. With the help of this ML and some luck, I think the following patch that patch dma_cache_maint should be applied to dma_cache_maint_contiguous, which is called by dma_cache_maint_page.

Broadcast the DMA cache operations on ARMv6 SMP hardware
http://linux-arm.org/git?p=linux-2.6.git;a=commitdiff;h=f1c242dc5f326713578e469c9f5be647978ebe24

Best Regrds,
Mac LIn

 		 	   		  
_________________________________________________________________
Windows Live: Friends get your Flickr, Yelp, and Digg updates when they e-mail you.
http://www.microsoft.com/middleeast/windows/windowslive/see-it-in-action/social-network-basics.aspx?ocid=PID23461::T:WLMTAGL:ON:WL:en-xm:SI_SB_3:092010
-------------- next part --------------
A non-text attachment was scrubbed...
Name: patch
Type: application/octet-stream
Size: 772 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091207/9222ab68/attachment.obj>
