From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 23 Jul 2014 00:29:16 +0200
Subject: [PATCH 0/6] net: mvpp2: Assorted fixes
In-Reply-To: <20140722.131639.1180592286226896307.davem@davemloft.net>
References: <1405961296-5846-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20140721.202749.913689946944612851.davem@davemloft.net>
 <20140722144519.GA682@arch.cereza>
 <20140722.131639.1180592286226896307.davem@davemloft.net>
Message-ID: <20140723002916.67a0bb3c@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear David Miller,

On Tue, 22 Jul 2014 13:16:39 -0700 (PDT), David Miller wrote:

> >> This series does not apply to the 'net' tree at all, please respin
> >> and resubmit.
> > 
> > This series applies on net-next.
> > 
> > Sorry for not mentioning it,
> 
> They are bonafide bug fixes, therefore should be targetted at 'net'.

Except that I believe they are fixes for a driver which itself is in
net-next, i.e scheduled for 3.17.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
