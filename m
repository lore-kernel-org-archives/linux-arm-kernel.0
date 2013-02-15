From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 15 Feb 2013 13:45:00 +0530
Subject: [PATCH v7 0/2] ARM: davinci: remoteproc support
In-Reply-To: <cover.1359684780.git.rtivy@ti.com>
References: <cover.1359684780.git.rtivy@ti.com>
Message-ID: <511DEE84.7070303@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2/1/2013 7:54 AM, Robert Tivy wrote:
> This patch series adds remoteproc support for OMAP-L138, along with needed
> supporting mach-davinci infrastructure.
> 
> These patches are based on Sekhar's commit id
> 601ac613155476701ff2155aa11853cad70d7ce5
> at git://gitorious.org/linux-davinci/linux-davinci.git
> 
> Some notes for reviewers...
> 
> DOCUMENTATION maintainers: patch 2/2 in this series contains a change to
> kernel-parameters.txt that adds a description for a new kernel command-line
> parameter, along with the code that defines the new kernel command-line
> parameter.  You are, of course, free to look at the whole series, but only
> patch 2/2 is of particular interest.
> 
> This is actually a subset of the complete patch series, since the other
> patches in this set have already been committed to a staging area by the
> tree maintainer.
> 
> Sekhar, once this is accepted, please remember to apply patch [PATCH v5 8/9].

Please add this patch to this series, next time you spin it.

Thanks,
Sekhar
