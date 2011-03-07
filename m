From: olof@lixom.net (Olof Johansson)
Date: Mon, 7 Mar 2011 15:13:49 -0800
Subject: [PATCH 0/3] Tegra i2c board changes + defconfig update
In-Reply-To: <AANLkTimWi2z30tBK_1N_6gjqgbugCeCwc1oV3zWtModj@mail.gmail.com>
References: <1299486399-21761-1-git-send-email-olof@lixom.net>
	<AANLkTikxNgsE37t86VkLamzzt9W-E7jBTOTfXkqEvK9p@mail.gmail.com>
	<20110307200452.GM1829@sirena.org.uk>
	<AANLkTimWi2z30tBK_1N_6gjqgbugCeCwc1oV3zWtModj@mail.gmail.com>
Message-ID: <AANLkTikjoRVjbLhf_QbLu41ZKM+=q+nMxbAk81AU=O5y@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 7, 2011 at 12:07 PM, Colin Cross <ccross@android.com> wrote:
> On Mon, Mar 7, 2011 at 12:04 PM, Mark Brown
> <broonie@opensource.wolfsonmicro.com> wrote:
>> On Mon, Mar 07, 2011 at 11:59:02AM -0800, Colin Cross wrote:
>>
>>> linux-next. ?There shouldn't be any conflicts with linux-next, and
>>> there is no need for linux-next to build after merging some of its
>>> branches.
>>
>> -next gets built after each merge so the tree does need to merge without
>> the trees that get merged later on.
>
> Ok, we can make sure Tegra is merged after i2c and asoc, in which case
> it should build fine.

Main drawback is that the tegra main for-next branch doesn't build on
its own then. Not a big deal, especially not this close to the merge
window, IMHO.

I'll send a new pull request picking up the recently posted patches
then. I'm actually OK with the paz00 patches going in .39 myself,
since they don't impact any of the existing code, so nothing can
regress because of them.

New pull request in a bit.

-Olof
