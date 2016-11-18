From: olof@lixom.net (Olof Johansson)
Date: Thu, 17 Nov 2016 16:36:31 -0800
Subject: [GIT PULL] ARM: mvebu: fixes for v4.9 (#1)
In-Reply-To: <87twbfc8fh.fsf@free-electrons.com>
References: <87twbfc8fh.fsf@free-electrons.com>
Message-ID: <20161118003631.GB8578@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 10, 2016 at 10:49:06PM +0100, Gregory CLEMENT wrote:
> Hi,
> 
> Here is the first pull request for fixes for mvebu for v4.9.
> 
> Gregory
> 
> The following changes since commit bc33b0ca11e3df467777a4fa7639ba488c9d4911:
> 
>   Linux 4.9-rc4 (2016-11-05 16:23:36 -0700)
> 
> are available in the git repository at:
> 
>   git://git.infradead.org/linux-mvebu.git tags/mvebu-fixes-4.9-1
> 
> for you to fetch changes up to 8d897006fe9206d64cbe353310be26d7c911e69d:
> 
>   arm64: dts: marvell: add unique identifiers for Armada A8k SPI controllers (2016-11-09 09:44:08 +0100)
> 
> ----------------------------------------------------------------
> mvebu fixes for 4.9 (part 1)
> 
> All of them are fixes for arm64 device tree
> 
> - 2 for the SPI node on the Armada 7K/8K
> - 1 for the clock node on the Armada 37xx
> 

Hi, merged. But please be a bit more descriptive in the pull request of _why_
we should pick it up in the future.

The patches themselves are well described in this case, so looking at those
helped tell that it made sense to include.

No need for a full essay, just a few words about "why" instead of necessarily
just "what" in the tag description!


Thanks,

-Olof
