From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Wed, 05 Mar 2014 15:36:18 +1100
Subject: [PATCH 1/2] sched: Remove unused mc_capable() and smt_capable()
In-Reply-To: <20140304210737.16893.54289.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20140304210621.16893.8772.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20140304210737.16893.54289.stgit@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <1393994178.11372.2.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2014-03-04 at 14:07 -0700, Bjorn Helgaas wrote:
> Remove mc_capable() and smt_capable().  Neither is used.
> 
> Both were added by 5c45bf279d37 ("sched: mc/smt power savings sched
> policy").  Uses of both were removed by 8e7fbcbc22c1 ("sched: Remove stale
> power aware scheduling remnants and dysfunctional knobs").
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
