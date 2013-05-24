From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 24 May 2013 09:15:27 +0200
Subject: [PATCH 0/9] Switch internal registers address to 0xF1 on Armada
 370/XP
In-Reply-To: <20130523230911.GR18614@n2100.arm.linux.org.uk>
References: <1369132414-18959-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201305232240.03959.arnd@arndb.de>
 <20130523230911.GR18614@n2100.arm.linux.org.uk>
Message-ID: <201305240915.27847.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 24 May 2013, Russell King - ARM Linux wrote:
> No, I'm not asking about the principle.  I'm asking _in this particular
> problem case_ who provides the DT blob?
> 
> So the person to answer that question is Thomas or someone who is using
> the boards concerned.

But there is no problem on those boards /yet/. So far, the two boards
always come with the known 0xd0 configuration that match the DTs
we have, independent of where they come from.

Thomas wants to be prepared for them to do something stupid, and he
anticipates that they are going to do it in a particular way, but
he says that he has no control over them, so it's all speculation
at this point, unless we do something stupid and change the dts
files in the kernel to no longer match the current hardware.

	Arnd
