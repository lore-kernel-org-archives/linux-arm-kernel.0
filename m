From: rientjes@google.com (David Rientjes)
Date: Thu, 12 Apr 2018 13:46:36 -0700 (PDT)
Subject: [PATCH v4] mm: remove odd HAVE_PTE_SPECIAL
In-Reply-To: <1523533733-25437-1-git-send-email-ldufour@linux.vnet.ibm.com>
References: <20180411110936.GG23400@dhcp22.suse.cz>
 <1523533733-25437-1-git-send-email-ldufour@linux.vnet.ibm.com>
Message-ID: <alpine.DEB.2.21.1804121346250.22780@chino.kir.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 12 Apr 2018, Laurent Dufour wrote:

> Remove the additional define HAVE_PTE_SPECIAL and rely directly on
> CONFIG_ARCH_HAS_PTE_SPECIAL.
> 
> There is no functional change introduced by this patch
> 
> Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>

Acked-by: David Rientjes <rientjes@google.com>
