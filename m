From: olof@lixom.net (Olof Johansson)
Date: Wed, 13 Jul 2011 16:17:42 -0700
Subject: [PATCH 2/2] ARM: Tegra: Seaboard: Add USB devices
In-Reply-To: <1310594272-8229-2-git-send-email-swarren@nvidia.com>
References: <1310594272-8229-1-git-send-email-swarren@nvidia.com>
	<1310594272-8229-2-git-send-email-swarren@nvidia.com>
Message-ID: <CAOesGMjXpfYXYVbX_WqHoUE0A80LDH-yG8V72of0CVbZb8xNog@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 13, 2011 at 2:57 PM, Stephen Warren <swarren@nvidia.com> wrote:
> Seaboard has a couple of external USB ports. Add the platform devices and
> GPIO infra-structure to enable these.
>
> I tested both ports with a mouse on Seaboard non-clamshell.
>
> This change is extracted from code in the ChromeOS 2.6.38 kernel.
>
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Acked-by: Olof Johansson <olof@lixom.net>
