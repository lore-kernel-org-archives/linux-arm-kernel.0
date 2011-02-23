From: olof@lixom.net (Olof Johansson)
Date: Wed, 23 Feb 2011 13:21:31 -0800
Subject: [PATCH 5/5] ARM: Tegra: Enable Harmony audio support
In-Reply-To: <AANLkTikk6f0Nv8XZEmY4-85FtBE1re9hKqgFRNZkyPfz@mail.gmail.com>
References: <1298487532-5000-1-git-send-email-swarren@nvidia.com>
	<1298487532-5000-6-git-send-email-swarren@nvidia.com>
	<AANLkTimffVNK2EmTqypQcrWHLisf3c8_dMsHwSbv-nWi@mail.gmail.com>
	<AANLkTikk6f0Nv8XZEmY4-85FtBE1re9hKqgFRNZkyPfz@mail.gmail.com>
Message-ID: <AANLkTikYhiaAgZLJ5APpbTVn-2_zdrU5S_7b_SFnu1d-@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> The GPIO numbers above TEGRA_NR_GPIOS are allocated by the board, and
> this is in board-harmony.h, so I think its OK.

On second thought, it's probably even preferred, since otherwise the
dynamic allocation can mess up the static ones.

>> Does it need a hardcoded GPIO base, or can it use the dynamic one
>> (i.e. use -1 here)? I don't even see any reference to gpio_base in the
>> driver...
> I assume that is in the ASoC tree. ?The platform data in tegra
> for-next does not include a gpio_base entry.

Yeah, I only looked at the current driver in .37, my bad.


-Olof
