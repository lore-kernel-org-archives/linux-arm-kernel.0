From: Bin.Shi@csr.com (Bin Shi)
Date: Wed, 05 May 2010 09:46:54 +0800
Subject: Linux Bluetooth HFP through usp pcm design questions
Message-ID: <1273024014.9369.1.camel@ben-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

        
        

I am working on vendor ARM1136 platform. Nowdays, I want to integrate
CSR BC06 chip to my board with HFP profile, bluetooth chip connect its
pcm interface with platform's usp interface. 

        

As I know, HFP profile should has at least two deamons, one for host and
one for target(BC06). In low level, driver for usp pcm should be
available, which is compatible with BC06 frame format. Now, audio path
is OK for playback and capture with ALSA.

        

My questions are:
1) How could I control stream path: eg headphone voice->BC06->usp
interface->platform speaker?
2) Should it be strictly sync for controlling this application?
3) Data format between usp interface and headphone interface(bypass
bluetooth) should be pcm stream?

        
        

Any suggestion would be welcomed! Thanks.




---
Best Regards,
Bin Shi








Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100505/efcc9f18/attachment-0001.htm>
