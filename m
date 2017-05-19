From: olof@lixom.net (Olof Johansson)
Date: Fri, 19 May 2017 00:00:57 -0700
Subject: [PATCH 1/2] arm64: defconfig: sync with savedefconfig
In-Reply-To: <20170517215230.15108-1-robh@kernel.org>
References: <20170517215230.15108-1-robh@kernel.org>
Message-ID: <20170519070057.GE9628@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 17, 2017 at 04:52:29PM -0500, Rob Herring wrote:
> Sync the defconfig with savedefconfig as config options change/move over
> time.
> 
> Generated with the following commands:
> make defconfig
> make savedefconfig
> cp defconfig arch/arm64/configs/defconfig
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> I just found that Timur already sent pretty much the same thing. Take 
> your pick what to apply. Mine is on top of 4.12-rc1.

This one was sitting there so I applied it.


-Olof
