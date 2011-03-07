From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 7 Mar 2011 20:04:52 +0000
Subject: [PATCH 0/3] Tegra i2c board changes + defconfig update
In-Reply-To: <AANLkTikxNgsE37t86VkLamzzt9W-E7jBTOTfXkqEvK9p@mail.gmail.com>
References: <1299486399-21761-1-git-send-email-olof@lixom.net>
	<AANLkTikxNgsE37t86VkLamzzt9W-E7jBTOTfXkqEvK9p@mail.gmail.com>
Message-ID: <20110307200452.GM1829@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 07, 2011 at 11:59:02AM -0800, Colin Cross wrote:

> linux-next.  There shouldn't be any conflicts with linux-next, and
> there is no need for linux-next to build after merging some of its
> branches.

-next gets built after each merge so the tree does need to merge without
the trees that get merged later on.
