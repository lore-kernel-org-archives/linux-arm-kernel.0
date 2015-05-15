From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 15 May 2015 12:43:34 +0200
Subject: [GIT PULL 7/8] ARM: tegra: Devicetree changes for v4.2-rc1
In-Reply-To: <3095273.etWfHSyyvC@wuerfel>
References: <1431524980-13599-1-git-send-email-thierry.reding@gmail.com>
 <1431524980-13599-8-git-send-email-thierry.reding@gmail.com>
 <3095273.etWfHSyyvC@wuerfel>
Message-ID: <20150515104332.GB20474@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 13, 2015 at 06:09:20PM +0200, Arnd Bergmann wrote:
> On Wednesday 13 May 2015 15:49:39 Thierry Reding wrote:
> > ARM: tegra: Devicetree changes for v4.2-rc1
> > 
> > Contains a couple of fixes and additions to device tree files. The most
> > notable change is a fix for a misapplied patch that was only exposed by
> > a recent change in the regulator subsystem that caused USB to break on
> > Tegra124 recently.
> 
> It sounds like I should merge commit a4b6916cb35 ("ARM: tegra: Correct
> which USB controller has the UTMI pad registers") into the 4.1 fixes
> branch as well. Please confirm.

I think you already did. I sent out a pull request for that not very
long ago and I must have forgotten to drop this patch from the Tegra
tree after it got applied to arm-soc. The merge commit for this in
the fixes branch is here:

	https://git.kernel.org/cgit/linux/kernel/git/arm/arm-soc.git/commit/?h=fixes&id=155171274d1dd9d9e5a012bd912c592402aa31d2

Hopefully git will be able to merge these together without conflicts.
Sorry about the dupe.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150515/7e58b364/attachment.sig>
