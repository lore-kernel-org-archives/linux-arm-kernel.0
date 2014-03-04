From: davem@davemloft.net (David Miller)
Date: Tue, 04 Mar 2014 16:48:06 -0500 (EST)
Subject: [PATCH 2/2] sparc64: Remove unused sparc64_multi_core
In-Reply-To: <20140304210744.16893.75929.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20140304210621.16893.8772.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20140304210744.16893.75929.stgit@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <20140304.164806.1723542180554308406.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 04 Mar 2014 14:07:44 -0700

> Remove sparc64_multi_core because it's not used any more.
> 
> It was added by a2f9f6bbb30e ("Fix {mc,smt}_capable()"), and the last uses
> were removed by e637d96bf462 ("sched: Remove unused mc_capable() and
> smt_capable()").
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Acked-by: David S. Miller <davem@davemloft.net>
