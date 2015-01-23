From: olof@lixom.net (Olof Johansson)
Date: Fri, 23 Jan 2015 13:47:53 -0800
Subject: [GIT PULL 2/3] omap defconfig changes for v3.20
In-Reply-To: <54be9e8c.6a58460a.68af.68a6SMTPIN_ADDED_BROKEN@mx.google.com>
References: <pull-1421777718-852183>
 <54be9e8c.6a58460a.68af.68a6SMTPIN_ADDED_BROKEN@mx.google.com>
Message-ID: <20150123214753.GB20896@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 20, 2015 at 10:25:39AM -0800, Tony Lindgren wrote:
> The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:
> 
>   Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.20/defconfig-modular
> 
> for you to fetch changes up to 697549cdd637841e7c88d0014fe25dfbb72565de:
> 
>   ARM: omap2plus_defconfig: Enable OHCI & EHCI HCD support (2015-01-20 09:46:31 -0800)
> 
> ----------------------------------------------------------------
> Defconfig changes for omap2plus_defconfig to make it more modular,
> and to add few more drivers found on various boards.

Merged, thanks.

BTW, please remember to enable drivers in the multi_v7 defconfigs too
where it makes sense. Not sure if any of these fall in that category,
I didn't check closely.


-Olof
