From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 22 May 2013 14:43:36 +0100
Subject: [PATCH 0/9] Switch internal registers address to 0xF1 on
 Armada 370/XP
In-Reply-To: <519C9779.1040104@gmail.com>
References: <1369132414-18959-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130521193803.GA20882@1wt.eu> <519C9779.1040104@gmail.com>
Message-ID: <20130522134336.GE18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 22, 2013 at 12:01:29PM +0200, Sebastian Hesselbarth wrote:
> I tried the above on Dove which is possibly affected by the workaround
> as it is also ARMv7. In Dove you can access unmapped addresses without
> any problems, but as Thomas already stated Armada 370/XP just hang.
> Must be some default AHB slave in Dove, which Armada 370/XP is missing.

It may be some clock setting somewhere on the 370/XP.  The Dove will hang
as well if you prod at peripherals which you've turned their clocks off.
