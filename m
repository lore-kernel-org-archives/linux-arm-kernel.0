From: pawel.moll@arm.com (Pawel Moll)
Date: Thu, 18 Sep 2014 10:19:33 +0100
Subject: [PATCH 2/2] ARM: vexpress: Remove non-DT code
In-Reply-To: <20140918075758.GA12361@n2100.arm.linux.org.uk>
References: <1410359618-3441-1-git-send-email-pawel.moll@arm.com>
 <1410359618-3441-2-git-send-email-pawel.moll@arm.com>
 <20140910145818.GG12361@n2100.arm.linux.org.uk>
 <1410363657.23973.48.camel@hornet>
 <20140917152735.GU12361@n2100.arm.linux.org.uk>
 <alpine.LFD.2.11.1409172059050.8647@knanqh.ubzr>
 <20140918075758.GA12361@n2100.arm.linux.org.uk>
Message-ID: <1411031973.8965.4.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2014-09-18 at 08:57 +0100, Russell King - ARM Linux wrote:
> So, until we get to the bottom of this, I need Versatile Express support
> to stay as-is, so there's no extraneous variables in the platform.  That
> means right now I need the legacy stuff to stay as switching to DT will
> add a huge variable into what's going on.

No problem, this patch can wait till 3.19.

Pawel
