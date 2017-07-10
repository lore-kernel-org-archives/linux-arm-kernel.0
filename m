From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 10 Jul 2017 08:54:21 -0700
Subject: [PATCH 5/6] irqchip: brcmstb-l2: Abstract register accesses
In-Reply-To: <20170707192016.13001-6-opendmb@gmail.com>
References: <20170707192016.13001-1-opendmb@gmail.com>
 <20170707192016.13001-6-opendmb@gmail.com>
Message-ID: <7cd8c234-f048-fdc7-6e66-277de550265a@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/07/2017 12:20 PM, Doug Berger wrote:
> Added register block offsets to the brcmstb_l2_intc_data structure
> for the status and mask registers to support reading the active
> interupts in an abstracted way.  It seems like an irq_chip method
> should have been provided for this, but it's not there yet.
> 
> Abstracted the implementation of the handler, suspend, and resume
> functions to not use any hard coded register offsets.
> 
> Signed-off-by: Doug Berger <opendmb@gmail.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
