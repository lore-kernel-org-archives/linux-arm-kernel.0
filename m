From: ryan@bluewatersys.com (Ryan Mallon)
Date: Mon, 14 Jun 2010 10:51:06 +1200
Subject: [PATCH 0/5] SPEAr3xx: Unify build of SPEAr3xx platforms
In-Reply-To: <1275717955-14545-1-git-send-email-ryan@bluewatersys.com>
References: <1275717955-14545-1-git-send-email-ryan@bluewatersys.com>
Message-ID: <4C1560DA.5040803@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ryan Mallon wrote:
> Rework the SPEAr3xx code to allow all three SPEAr3xx platforms to be
> built into a single kernel.
> 
> I do not have access to any SPEAr3xx hardware, so the patch series is
> build tested only.

Any interest in this patch series, or anybody with hardware that is able
to test it?

Patch 1/5 is a simple cleanup patch which makes a bunch of local
structures static, so it doesn't change functionality. Patch 5/5 can be
dropped until the path forward for cleaning up the defconfigs has been
decided. The other patches should not change the functionality if only
one of the platforms is compiled in, but should also allow all three
SPEAr3xx platforms to be built and run in a single kernel.

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
