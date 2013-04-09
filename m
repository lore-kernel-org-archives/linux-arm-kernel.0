From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 9 Apr 2013 11:25:41 +0200
Subject: [PATCH] clk: si5351: Add gapless tuning for SI5351 PLL
In-Reply-To: <1365495975-792-1-git-send-email-michal.bachraty@streamunlimited.com>
References: <1365495975-792-1-git-send-email-michal.bachraty@streamunlimited.com>
Message-ID: <CABJ1b_RW=UUxmTrYOsx2wsDm1egs9DL3dWtat0--5kqec9-rQA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 9, 2013 at 10:26 AM, Michal Bachraty
<michal.bachraty@streamunlimited.com> wrote:
> For gapless tuning, there is no need for PLL reset and clkout power-down
> when tuning output. "silabs,gapless-tuning" parameter enables gapless tuning
> for specific clock output.

Michal,

does gapless tuning have any constraints? Can we use it for all rate
changes or determine the
need for pll reset by rate offset?

Sebastian
