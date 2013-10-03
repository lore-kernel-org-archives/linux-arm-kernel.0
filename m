From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 3 Oct 2013 14:44:57 +0200
Subject: [PATCH RESEND] PCI: mvebu: Dynamically detect if the PEX link
 is up to enable hot plug
In-Reply-To: <1380650281-16175-1-git-send-email-jgunthorpe@obsidianresearch.com>
References: <1380650281-16175-1-git-send-email-jgunthorpe@obsidianresearch.com>
Message-ID: <20131003144457.4131aea3@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jason Gunthorpe,

On Tue,  1 Oct 2013 11:58:00 -0600, Jason Gunthorpe wrote:
> Otherwise hotplugging the PEX doesn't work at all since the driver
> detects the link state at probe time. Simply replacing the two tests
> of haslink with a register read is enough to fix it.
> 
> Tested on kirkwood with repeated plug/unplug of the link partner.
> 
> Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>

Acked-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Tested-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
-- 
Thomas Petazzoni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
