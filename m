From: paul@pwsan.com (Paul Walmsley)
Date: Sun, 10 Apr 2016 17:57:22 +0000 (UTC)
Subject: [PATCH 3/4] ARM: DRA7: hwmod: Add data for GPTimer 12
In-Reply-To: <1459892652-47845-4-git-send-email-s-anna@ti.com>
References: <1459892652-47845-1-git-send-email-s-anna@ti.com>
 <1459892652-47845-4-git-send-email-s-anna@ti.com>
Message-ID: <alpine.DEB.2.02.1604101757100.11457@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 5 Apr 2016, Suman Anna wrote:

> Add the hwmod data for GPTimer 12. GPTimer 12 is present in
> WKUPAON power domain and is clocked from a secure 32K clock.
> GPTimer 12 serves as a secure timer on HS devices, but is
> available for kernel on regular GP devices.
> 
> The hwmod link is registered only on GP devices. The hwmod data
> also reused the existing timer class instead of reintroducing
> the identical dra7xx_timer_secure_sysc class which was dropped
> in commit edec17863362 ("ARM: DRA7: hwmod: Fix the hwmod class
> for GPTimer4").
> 
> Cc: Paul Walmsley <paul@pwsan.com>
> Signed-off-by: Suman Anna <s-anna@ti.com>

Thanks, queued for v4.7.


- Paul
