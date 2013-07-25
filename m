From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Thu, 25 Jul 2013 12:48:18 +0100
Subject: [PATCH 1/4] ARM: alignment: correctly decode instructions in
 BE8 mode.
In-Reply-To: <20130724171613.GB4610@localhost.localdomain>
References: <1374510833-25716-1-git-send-email-ben.dooks@codethink.co.uk>
 <1374510833-25716-2-git-send-email-ben.dooks@codethink.co.uk>
 <20130724171613.GB4610@localhost.localdomain>
Message-ID: <51F11082.6070708@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/07/13 18:16, Dave Martin wrote:
> instr = thumb2arm(tinstr);

oops, removed it by accident. thanks for spotting.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
