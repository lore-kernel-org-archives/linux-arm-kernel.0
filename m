From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 15 Mar 2017 14:57:51 -0700
Subject: [PATCH 3/3] ARM: brcmstb: Add entry for 7260
In-Reply-To: <20170309185120.1713-4-f.fainelli@gmail.com>
References: <20170309185120.1713-1-f.fainelli@gmail.com>
Message-ID: <20170315215751.15606-1-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 9 Mar 2017 10:51:20 -0800, Florian Fainelli <f.fainelli@gmail.com> wrote:
> BCM7260 has the same UART base address as 7268, order the entries by
> ascending chip number and alias the 7268 definition to the 7260
> definition.
>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---

Applied, thanks!
--
Florian
