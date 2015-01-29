From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 29 Jan 2015 09:10:42 +0100
Subject: [REQUEST PULL] mvebu-fixes-6
In-Reply-To: <20150128230113.GB3177@quad.lixom.net>
References: <20150128160231.GA28862@lunn.ch> <20150128172902.GA29434@lunn.ch>
 <20150128230113.GB3177@quad.lixom.net>
Message-ID: <20150129091042.15716170@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Olof Johansson,

On Wed, 28 Jan 2015 15:01:13 -0800, Olof Johansson wrote:

> > The following changes since commit 38bdf45f4aa5cb6186d50a29e6cbbd9d486a1519:
> > 
> >   bus: mvebu-mbus: fix support of MBus window 13 (2015-01-19 15:40:53 -0600)
> > 
> > are available in the git repository at:
> > 
> >   git://git.infradead.org/linux-mvebu.git tags/mvebu-fixes-3.19-6
> 
> Hrm, would have been nice not to have to take a regression fix for a fix.

Indeed, and it is entirely my fault, not Andrew's. The I/O coherency
disabling fix was working fine on Armada 370/XP, but not on Armada
375/38x. My fault of not checking on a sufficient number of platforms.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
