From: judith.baumgarten@tu-cottbus.de (Judith Baumgarten)
Date: Thu, 27 Aug 2009 18:23:08 +0200
Subject: How to work out the cause of a DMA Bus Error (QCI PXA320)?
Message-ID: <20090827182308.19411cv37br99zvw@webmail.tu-cottbus.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I'm still working on the pxa_camera driver for PXA320. At the moment I  
can capture some frames (RAW mode), but then I get a DMA Bus Error.  
Has anyone an idea how to deal with that error or work out the  
specific cause?
The manual says, that if an error occures the channel is stopped until  
it's reprogrammed and the corresponding RUN bit is set, but there are  
no RUN bits in QCI DMA. So I don't see a chance to start it again...

Thanks,
Judith

----------------------------------------------------------------
This message was sent using IMP, the Internet Messaging Program.
