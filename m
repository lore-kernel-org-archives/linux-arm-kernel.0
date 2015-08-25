From: p.fedin@samsung.com (Pavel Fedin)
Date: Tue, 25 Aug 2015 14:01:22 +0300
Subject: [PATCH 2/5] gic-its: Allow pci_requester_id to be overridden.
In-Reply-To: <55D5F0E1.30702@caviumnetworks.com>
References: <1436979285-8177-1-git-send-email-ddaney.cavm@gmail.com>
 <1436979285-8177-3-git-send-email-ddaney.cavm@gmail.com>
 <01a101d0db52$2d23b360$876b1a20$@samsung.com>
 <55D5F0E1.30702@caviumnetworks.com>
Message-ID: <012a01d0df25$61515ad0$23f41070$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Hello!

> >   What if instead of this function we simply add a field to a struct pci_bus ? Then bus driver
would
> > fill in HW-specific ID bits for every bus.
> >   I can send a patch if interested.
> 
> There is a lot of work being done in the upstream to extract the proper
> information from the device tree.  We are going to piggyback on that for
> the next versions of the patch.

 Where can i take a look at the code?

Kind regards,
Pavel Fedin
Expert Engineer
Samsung Electronics Research center Russia
