From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Tue, 18 Dec 2012 12:35:25 +0530
Subject: [PATCH 2/4] ARM: tegra: add connection name for uart clock table
In-Reply-To: <50CF9233.3010506@wwwdotorg.org>
References: <1355746101-15291-1-git-send-email-ldewangan@nvidia.com>
 <1355746101-15291-3-git-send-email-ldewangan@nvidia.com>
 <50CF9233.3010506@wwwdotorg.org>
Message-ID: <50D015B5.8050805@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 18 December 2012 03:14 AM, Stephen Warren wrote:
> On 12/17/2012 05:08 AM, Laxman Dewangan wrote:
>> Add connection name "uart-clk" for the uart clock information.
> Does the UART receive more than one clock, so that it actually cares
> what the clock connection name is? If not, can we just drop this patch?

I like to have this patch because:
- In future, I want to also get the name of the clock source and set 
parent of uart clock properly.
- I want to switch the parent clock source dynamically between CLKM and 
PLLP to achieve more power optimization i.e. use CLKM wherever possible..
