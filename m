From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 22 Jul 2014 20:20:04 -0300
Subject: [PATCH 0/6] net: mvpp2: Assorted fixes
In-Reply-To: <20140723002916.67a0bb3c@free-electrons.com>
References: <1405961296-5846-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20140721.202749.913689946944612851.davem@davemloft.net>
 <20140722144519.GA682@arch.cereza>
 <20140722.131639.1180592286226896307.davem@davemloft.net>
 <20140723002916.67a0bb3c@free-electrons.com>
Message-ID: <20140722232004.GA7838@arch.cereza>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23 Jul 12:29 AM, Thomas Petazzoni wrote:
> On Tue, 22 Jul 2014 13:16:39 -0700 (PDT), David Miller wrote:
> 
> > >> This series does not apply to the 'net' tree at all, please respin
> > >> and resubmit.
> > > 
> > > This series applies on net-next.
> > > 
> > > Sorry for not mentioning it,
> > 
> > They are bonafide bug fixes, therefore should be targetted at 'net'.
> 
> Except that I believe they are fixes for a driver which itself is in
> net-next, i.e scheduled for 3.17.
> 

That's right. These are fixes for the new mvpp2 driver, which is only
in net-next.
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
