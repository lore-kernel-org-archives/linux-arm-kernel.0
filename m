From: olof@lixom.net (Olof Johansson)
Date: Wed, 12 Oct 2011 15:41:31 -0700
Subject: [PATCH v4 3/4] gpio/tegra: Convert to a platform device
In-Reply-To: <1318371375-4083-3-git-send-email-swarren@nvidia.com>
References: <1318371375-4083-1-git-send-email-swarren@nvidia.com>
	<1318371375-4083-3-git-send-email-swarren@nvidia.com>
Message-ID: <20111012224131.GD25128@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 11, 2011 at 04:16:14PM -0600, Stephen Warren wrote:
> v3: Make regs variable static. Remove empty init of tegra_gpio_banks.
> 
> v2: Retrieve IRQ and memory addresses from resources instead of hard-
> coding them. Add back initialization of tegra_gpio_chip.of_node.

In the future, please move the revision log to below the ---, and just have
the main patch description above, since that is what goes into the git repo.

> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Otherwise, patch looks good. Due to dependencies between this, the rest
of this patch series and the pinmux changes, I'll hold off on it until
the dependencies land (i.e. target it for 3.3). We're cutting it very close
to the merge window as it is, I'll start for-3.3 branches shortly.


-Olof
