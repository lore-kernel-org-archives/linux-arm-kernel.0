From: olof@lixom.net (Olof Johansson)
Date: Sun, 18 Jun 2017 20:23:56 -0700
Subject: [GIT PULL 1/5] Broadcom soc changes for 4.13
In-Reply-To: <6529bf30-2127-b8a9-c064-0f5326ff4017@gmail.com>
References: <20170612173109.11188-1-f.fainelli@gmail.com>
 <6529bf30-2127-b8a9-c064-0f5326ff4017@gmail.com>
Message-ID: <20170619032356.GG30022@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 13, 2017 at 12:37:55PM -0700, Florian Fainelli wrote:
> On 06/12/2017 10:31 AM, Florian Fainelli wrote:
> > The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:
> > 
> >   Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)
> > 
> > are available in the git repository at:
> > 
> >   http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.13/soc
> > 
> > for you to fetch changes up to 27d9fa06c122b135ad7552fa3138c3b47e5776c5:
> > 
> >   ARM: BCM: Enable thermal support for NSP SoCs (2017-05-19 11:30:25 -0700)
> > 
> > ----------------------------------------------------------------
> > This pull request contains Broadcom ARM-based SoCs (non Device Tree) changes:
> > 
> > - Jon updates the Kconfig entry for Northstar Plus to have THERMAL and THERMAL_OF
> >   selected in order to get the NS/NSP thermal driver dependencies to be satistfied
> > 
> > ----------------------------------------------------------------
> > Jon Mason (1):
> >       ARM: BCM: Enable thermal support for NSP SoCs
> 
> Arnd, Olof, Kevin,
> 
> Eric sent me his pull requests this morning, so I will be re-submitting
> these shortly along with his changes, sorry for the delay.

No worries. Feel free to do incremental pull requests for the new material next
time, if it's easier for you.


-Olof
