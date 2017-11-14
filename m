From: marc_gonzalez@sigmadesigns.com (Marc Gonzalez)
Date: Tue, 14 Nov 2017 13:56:34 +0100
Subject: [PATCH v3 2/4] net: nb8800: Simplify nb8800_pause_config()
In-Reply-To: <yw1x1sl12fx8.fsf@mansr.com>
References: <230165aa-eaf1-6e2b-7ff3-45b3ee4ffc62@sigmadesigns.com>
 <dd0c2014-8ef9-749c-16d3-6a56f4161658@sigmadesigns.com>
 <yw1x1sl12fx8.fsf@mansr.com>
Message-ID: <569542b1-8e56-d7da-f7a0-affd89bfed62@sigmadesigns.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/11/2017 13:38, M?ns Rullg?rd wrote:

> Marc Gonzalez writes:
> 
>> The "flow control enable" bit can be tweaked, even if DMA is enabled.
> 
> No, it can't.  Maybe on some of your newer chips it can, but not on the
> older ones.

Again, I suppose you are referring to your SMP8642-based board.

Are you saying you tested this patch, and it doesn't work?
What are the symptoms?
