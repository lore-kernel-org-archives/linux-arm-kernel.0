From: laurentiu.tudor@nxp.com (Laurentiu Tudor)
Date: Thu, 4 Oct 2018 09:37:52 +0000
Subject: [GIT PULL] fixes for soc/fsl drivers for v4.19 take 2
In-Reply-To: <20181001225827.21946-1-leoyang.li@nxp.com>
References: <20181001225827.21946-1-leoyang.li@nxp.com>
Message-ID: <f1847dd8-0cbc-3be6-303f-73e5dac5e5d1@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Leo,

On 02.10.2018 01:58, Li Yang wrote:
> Hi arm-soc maintainers,
> 
> Please merge the updated fix for the following issue.
> 
> Regards,
> Leo
> 
> The following changes since commit 96fc74333f84cfdf8d434c6c07254e215e2aad00:
> 
>    soc: fsl: qe: Fix copy/paste bug in ucc_get_tdm_sync_shift() (2018-09-25 13:57:26 -0700)
> 
> are available in the Git repository at:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/leo/linux.git soc-fsl-fix-v4.19-2
> 
> for you to fetch changes up to 5a1eb8b9542884592a018829bb1ff20c9695d925:
> 
>    soc: fsl: qman_portals: defer probe after qman's probe (2018-10-01 17:47:43 -0500)
> 
> ----------------------------------------------------------------
> NXP/FSL SoC driver fixes for v4.19 round 2
> 
> - Fix crash of qman_portal by deferring its probe if qman is not probed
> 
> ----------------------------------------------------------------
> Laurentiu Tudor (2):
>        soc: fsl: qbman: add APIs to retrieve the probing status
>        soc: fsl: qman_portals: defer probe after qman's probe

There's a similar fix for bman portals [1]. I was under the impression 
that you plan to pick that up too.

[1] "soc/fsl/bman_portals: defer probe after bman's probe", found here:
https://lore.kernel.org/patchwork/patch/992009/

---
Thanks & Best Regards, Laurentiu
