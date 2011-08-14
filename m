From: olof@lixom.net (Olof Johansson)
Date: Sun, 14 Aug 2011 00:01:57 -0700
Subject: [RFC PATCH 05/12] arm/dt: Tegra: Add nvidia,gpios property to
	GPIO controller
In-Reply-To: <1313189697-21287-6-git-send-email-swarren@nvidia.com>
References: <1313189697-21287-1-git-send-email-swarren@nvidia.com>
	<1313189697-21287-6-git-send-email-swarren@nvidia.com>
Message-ID: <CAOesGMj8firxDz-kqkh=jwsbC_QRW+YSFpf7dh3WaOhseCg91w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 12, 2011 at 3:54 PM, Stephen Warren <swarren@nvidia.com> wrote:
> Add board-specific gpio node for Harmony and Seaboard. This lists the
> GPIOs used by the board. Note that not all GPIOs that exist on the board
> are listed; only those used by devices currently supported by device
> tree.


I don't want to bikeshed over this, but something like
"nvidia,enabled-gpios" could be a bit more descriptive. Either way is
OK though.

The property should be documented under the bindings Documentation/
hierarchy though.


-Olof
