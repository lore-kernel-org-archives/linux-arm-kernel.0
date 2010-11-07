From: cjb@laptop.org (Chris Ball)
Date: Sun, 7 Nov 2010 22:41:16 +0000
Subject: [PATCH v4 0/2] add support for the Marvell Dove SDHCI controller
In-Reply-To: <cover.1288293593.git.mike@compulab.co.il>
References: <cover.1288293593.git.mike@compulab.co.il>
Message-ID: <20101107224116.GD13608@void.printf.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

On Thu, Oct 28, 2010 at 09:23:51PM +0200, Mike Rapoport wrote:
> These patches add support for the Marvell Dove SDHCI controller.

Thanks, I've pushed these to mmc-next for the 2.6.38 merge now.

(Applied a minor correction: MMC_SDHCI_DOVE is a bool, not a tristate,
so I removed the "say Y or M" line.)

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
