From: olof@lixom.net (Olof Johansson)
Date: Tue, 25 Sep 2018 11:35:10 -0700
Subject: [GIT PULL] firmware: scmi: updates for v4.20
In-Reply-To: <20180918111716.GA23868@e107155-lin>
References: <20180918111716.GA23868@e107155-lin>
Message-ID: <20180925183510.cebyq474rnx5vnxk@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 18, 2018 at 12:17:17PM +0100, Sudeep Holla wrote:
> Hi ARM-SoC team,
> 
> I have based this one on v4.19-rc3 in order to avoid conflicts with the
> driver fix that went in after -rc2. Please pull !

No worries! This works well, you also have the choice of just using our fixes
branch at the time as your base if for some reason you prefer that (or at
later -rcs).

> The following changes since commit 11da3a7f84f19c26da6f86af878298694ede0804:
> 
>   Linux 4.19-rc3 (2018-09-09 17:26:43 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git tags/scmi-updates-4.20
> 
> for you to fetch changes up to 1a63fe9a2b1f47af5b2b7436b41824b14999c17a:
> 
>   firmware: arm_scmi: add a getter for power of performance states (2018-09-10 17:37:06 +0100)

Merged, thanks!


-Olof
