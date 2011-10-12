From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 12 Oct 2011 17:03:24 -0600
Subject: [PATCH v4 3/4] gpio/tegra: Convert to a platform device
In-Reply-To: <20111012224131.GD25128@quad.lixom.net>
References: <1318371375-4083-1-git-send-email-swarren@nvidia.com>
	<1318371375-4083-3-git-send-email-swarren@nvidia.com>
	<20111012224131.GD25128@quad.lixom.net>
Message-ID: <CACxGe6tf0Ly8AC-6xUeoMrVj3y0KHkrcgj87SerAaCAnNhfNqA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 12, 2011 at 4:41 PM, Olof Johansson <olof@lixom.net> wrote:
> On Tue, Oct 11, 2011 at 04:16:14PM -0600, Stephen Warren wrote:
>> v3: Make regs variable static. Remove empty init of tegra_gpio_banks.
>>
>> v2: Retrieve IRQ and memory addresses from resources instead of hard-
>> coding them. Add back initialization of tegra_gpio_chip.of_node.
>
> In the future, please move the revision log to below the ---, and just have
> the main patch description above, since that is what goes into the git repo.

No!  Keep it above the line so it shows up in the Linux commit log.
It makes it easier to know which version of a patch actually got
committed.  :-)

>> Signed-off-by: Stephen Warren <swarren@nvidia.com>
>
> Otherwise, patch looks good. Due to dependencies between this, the rest
> of this patch series and the pinmux changes, I'll hold off on it until
> the dependencies land (i.e. target it for 3.3). We're cutting it very close
> to the merge window as it is, I'll start for-3.3 branches shortly.

Actually, see if you can get it in via the same tree as the pinmux
changes.  Dependencies is not a reason to hold off from getting it
into linux-next.

g.
