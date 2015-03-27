From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Fri, 27 Mar 2015 13:25:43 +0100
Subject: at91 clocks
In-Reply-To: <20150327132003.6caf3689@bbrezillon>
References: <55117568.6090202@microbit.se> <20150325013201.3f01fc22@bbrezillon>
 <55127AA6.5050902@microbit.se> <20150325173751.0d6479df@bbrezillon>
 <5513D701.2080201@microbit.se> <20150326162827.041c051a@bbrezillon>
 <55152F3E.60004@microbit.se> <20150327132003.6caf3689@bbrezillon>
Message-ID: <20150327132543.08ad636c@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 27 Mar 2015 13:20:03 +0100
Boris Brezillon <boris.brezillon@free-electrons.com> wrote:


> > 
> > I tested with IS_ERR, changed this to IS_ERR_OR_NULL, but the pointer is ok.
> 
> Can you print clk_get_rate(parent_clk) result ?

Could you also paste me the whole clk_summary content ?


-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
