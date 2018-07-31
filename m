From: helgaas@kernel.org (Bjorn Helgaas)
Date: Tue, 31 Jul 2018 15:16:38 -0500
Subject: [PATCH V5 0/3] PCI: separate hotplug handling from fatal error
 handling
In-Reply-To: <4dd903ec-3e4c-d2fb-8216-95d60bba4e55@kernel.org>
References: <1530571967-19099-1-git-send-email-okaya@codeaurora.org>
 <20180731184457.GN45322@bhelgaas-glaptop.roam.corp.google.com>
 <4dd903ec-3e4c-d2fb-8216-95d60bba4e55@kernel.org>
Message-ID: <20180731201637.GA235890@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 31, 2018 at 11:54:58AM -0700, Sinan Kaya wrote:
> Hi Bjorn,
> 
> On 7/31/2018 11:44 AM, Bjorn Helgaas wrote:
> > There's been a ton of discussion about this, and I didn't see a clear
> > consensus emerge, so I'm going to drop it for now.  If it's still
> > needed, please repost it and I'll watch for reviewers.
> 
> I apologize, let me summarize the conversation for you.
> I proposed this [1]. Oza seems to be onboard [2].
> 
> Later, I posted v6 with this change last weekend.

Oops, I missed that this had been obsoleted, sorry for the noise.

> [patch v6 1/1] pci: pciehp: ignore link events when there is a fatal error
> pending
> 
> Lukas and I discussed the patch last weekend under this v6 thread.
> AFAIK, we agreed on the direction.
> 
> I'll post V7 with Lukas' comments and capture the detail from email
> into the commit message.
> 
> Let us know what you think about it.

Sounds good, I'll look for that.
