From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 13 Jul 2010 17:11:00 -0600
Subject: [RFC PATCH] Kconfig: Enable Kconfig fragments to be used for
	defconfig
In-Reply-To: <20100713230352.6781.18644.stgit@angua>
References: <20100713230352.6781.18644.stgit@angua>
Message-ID: <AANLkTilG016R6nnpy7COX4NZE6qWWO8ILvHAyyT4-bgV@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Typo correction:

2010/7/13 Grant Likely <grant.likely@secretlab.ca>:
[...]
> <board>.Kconfig defines new board specific config items (prefixed with
> "generateconfig_" which default to 'y' or 'm' and select the options
> that the platform cares about. ?It also then either the architecture

s/either the/either includes the/

> default Kconfig, or another Kconfig fragment that includes the default
> one (therefore the fragments can be 'stacked' to include, say, default
> options for the architecture, or particular chipset).
[...]
