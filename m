From: olof@lixom.net (Olof Johansson)
Date: Thu, 22 Oct 2015 10:05:44 -0700
Subject: [GIT PULL] PSCI 1.0 implementation for v4.4
In-Reply-To: <20151005145557.GA2705@red-moon>
References: <20151005145557.GA2705@red-moon>
Message-ID: <20151022170544.GG19953@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 05, 2015 at 03:55:57PM +0100, Lorenzo Pieralisi wrote:
> Hi Arnd, Kevin, Olof,
> 
> please consider pulling the following commits for v4.4.
> 
> The commits update the PSCI kernel interface implementation
> so that it becomes compliant with the PSCI v1.0 specification and
> also provide code that enables PSCI based suspend-to-RAM
> based on the newly introduced PSCI v1.0 System Suspend call.
> 
> Thanks,
> Lorenzo
> 
> The following changes since commit 9ffecb10283508260936b96022d4ee43a7798b4c:
> 
>   Linux 4.3-rc3 (2015-09-27 07:50:08 -0400)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/linux.git tags/firmware/psci-1.0
> 
> for you to fetch changes up to faf7ec4a92c0231d1079177095077c162eb9b466:
> 
>   drivers: firmware: psci: add system suspend support (2015-10-02 14:35:17 +0100)

THanks, and apologies for the delayed merge of this branch. I've added it to
our next/drivers now, and we're carrying it as drivers/psci on its own as well.


-Olof
