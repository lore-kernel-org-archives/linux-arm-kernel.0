From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 8 Nov 2011 08:42:15 -0700 (MST)
Subject: [PATCH v5 4/7] arm: omap4: hwmod: introduce emu hwmod
In-Reply-To: <1319467559-5518-5-git-send-email-ming.lei@canonical.com>
References: <1319467559-5518-1-git-send-email-ming.lei@canonical.com>
 <1319467559-5518-5-git-send-email-ming.lei@canonical.com>
Message-ID: <alpine.DEB.2.00.1111080837250.10451@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi

I just read 

http://comments.gmane.org/gmane.comp.embedded.pandaboard/168

Looks to me that the L3_EMU interconnect and the emulation IP blocks need 
to be added to the OMAP4 hwmod data, based on Section 2.2.1 "L3_EMU Memory 
Space Mapping" in the OMAP4460 TRM Rev. I.  If the clockdomain & 
powerdomain are correctly defined then the OMAP framework code will 
automatically enable these too.



- Paul
