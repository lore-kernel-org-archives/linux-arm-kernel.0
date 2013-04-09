From: michal.bachraty@streamunlimited.com (Michal Bachraty)
Date: Tue, 09 Apr 2013 15:49:37 +0200
Subject: [PATCH] clk: si5351: Add gapless tuning for SI5351 PLL
In-Reply-To: <CABJ1b_RW=UUxmTrYOsx2wsDm1egs9DL3dWtat0--5kqec9-rQA@mail.gmail.com>
References: <1365495975-792-1-git-send-email-michal.bachraty@streamunlimited.com>
 <CABJ1b_RW=UUxmTrYOsx2wsDm1egs9DL3dWtat0--5kqec9-rQA@mail.gmail.com>
Message-ID: <2031033.gNGydvIeAk@ganymedes>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sebastian,

> does gapless tuning have any constraints? Can we use it for all rate
> changes or determine the
> need for pll reset by rate offset?

Today I made some test measurements ( switching from 22.5MHz to 32kHz, then to 
50MHz, then to 1MHz) with good results: without any gaps and any side 
frequences.  So there are no constrains, and we can use it for any frequences. 

Best,
Michal
