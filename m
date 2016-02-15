From: will.deacon@arm.com (Will Deacon)
Date: Mon, 15 Feb 2016 19:40:38 +0000
Subject: [PATCH v3 1/5] arm64/perf: Rename Cortex A57 events
In-Reply-To: <e0ecaaaffb64cc0b2ecfd8852f718a3f1d642b5c.1454516082.git.jglauber@cavium.com>
References: <cover.1454516082.git.jglauber@cavium.com>
 <e0ecaaaffb64cc0b2ecfd8852f718a3f1d642b5c.1454516082.git.jglauber@cavium.com>
Message-ID: <20160215194037.GU6298@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 03, 2016 at 06:11:56PM +0100, Jan Glauber wrote:
> The implemented Cortex A57 events are not A57 specific.
> They are recommended by ARM and can be found on other
> ARMv8 SOCs like Cavium ThunderX too. Therefore move
> these events to the common PMUv3 table.

I can't find anything in the architecture that suggests these event
numbers are necessarily portable between implementations. Am I missing
something?

Will
