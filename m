From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 17 Jun 2015 22:48:56 +0200
Subject: [PATCH 9/9] ARM: mvebu: adjust board name and compatible for
 Armada 388 GP
In-Reply-To: <5581A0CD.30109@free-electrons.com>
References: <1434456785-23696-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1434456785-23696-10-git-send-email-thomas.petazzoni@free-electrons.com>
 <5581A0CD.30109@free-electrons.com>
Message-ID: <20150617224856.4a52c381@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Gregory CLEMENT,

On Wed, 17 Jun 2015 18:31:09 +0200, Gregory CLEMENT wrote:

> On 16/06/2015 14:13, Thomas Petazzoni wrote:
> > As the name of the Device Tree file name suggests, the Armada 388 GP
> > really contains an Armada 388 SoC, so this commit updates the board
> > name and compatible string in the Device Tree file.
> 
> Actually the name of the board (the one written on the box) is DB-88F6820-GP.
> And 88F6820 is the code name of Armada 385. But indeed the SoC is an Armada 388
> on our boards.

So what do you suggest exactly for the model and compatible strings?

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
