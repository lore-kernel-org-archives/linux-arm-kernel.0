From: olof@lixom.net (Olof Johansson)
Date: Sun, 6 Jul 2014 17:44:17 -0700
Subject: [GIT PULL 2/3] ARM: tegra: move fuse code out of arch/arm
In-Reply-To: <1403558626-13422-2-git-send-email-swarren@wwwdotorg.org>
References: <1403558626-13422-1-git-send-email-swarren@wwwdotorg.org>
 <1403558626-13422-2-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20140707004417.GE8469@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 23, 2014 at 03:23:45PM -0600, Stephen Warren wrote:
> This branch moves code related to the Tegra fuses out of arch/arm and
> into a centralized location which could be shared with ARM64. It also
> adds support for reading the fuse data through sysfs.

The new/moved misc driver isn't acked by any misc maintainer, so I can't
take this branch.

I saw no indication from searching the mailing list of that either,
so it wasn't just a missed acked-by.

I wonder if this code should go under drivers/soc/ instead?


-Olof
