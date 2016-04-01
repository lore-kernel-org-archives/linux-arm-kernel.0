From: dyoung@redhat.com (Dave Young)
Date: Fri, 1 Apr 2016 09:59:47 +0800
Subject: [PATCH v15 00/20] arm64 kexec kernel patches v15
In-Reply-To: <cover.1457977401.git.geoff@infradead.org>
References: <cover.1457977401.git.geoff@infradead.org>
Message-ID: <20160401015947.GA3835@dhcp-128-65.nay.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/14/16 at 05:47pm, Geoff Levand wrote:
> This series adds the core support for kexec re-boot and kdump on ARM64.  This
> version of the series combines Takahiro's kdump patches with my kexec patches.
> Please consider all patches for inclusion.
> 
> To load a second stage kernel and execute a kexec re-boot or to work with kdump
> on ARM64 systems a series of patches to kexec-tools [2], which have not yet been
> merged upstream, are needed.  Please update to the latest if you have been using
> an older version.
> 
> To examine vmcore (/proc/vmcore), you should use
>   - gdb v7.7 or later
>   - crash v7.1.1 or later
> 
> [1]  https://git.kernel.org/cgit/linux/kernel/git/geoff/linux-kexec.git
> [2]  https://git.kernel.org/cgit/linux/kernel/git/geoff/kexec-tools.git
> 

Geoff, for easier to review maybe you can send kexec patches first then AKASHI Takahiro
can send the kdump patches as a standalone patchset?

Thanks
Dave
