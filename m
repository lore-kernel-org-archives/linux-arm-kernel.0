From: ccross@android.com (Colin Cross)
Date: Mon, 7 Mar 2011 12:07:08 -0800
Subject: [PATCH 0/3] Tegra i2c board changes + defconfig update
In-Reply-To: <20110307200452.GM1829@sirena.org.uk>
References: <1299486399-21761-1-git-send-email-olof@lixom.net>
	<AANLkTikxNgsE37t86VkLamzzt9W-E7jBTOTfXkqEvK9p@mail.gmail.com>
	<20110307200452.GM1829@sirena.org.uk>
Message-ID: <AANLkTimWi2z30tBK_1N_6gjqgbugCeCwc1oV3zWtModj@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 7, 2011 at 12:04 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Mon, Mar 07, 2011 at 11:59:02AM -0800, Colin Cross wrote:
>
>> linux-next. ?There shouldn't be any conflicts with linux-next, and
>> there is no need for linux-next to build after merging some of its
>> branches.
>
> -next gets built after each merge so the tree does need to merge without
> the trees that get merged later on.

Ok, we can make sure Tegra is merged after i2c and asoc, in which case
it should build fine.
