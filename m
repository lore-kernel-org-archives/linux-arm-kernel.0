From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 6 Jun 2013 14:02:01 -0400
Subject: [PATCH 0/8] Support Marvell bootloaders remapping registers at
 different locations
In-Reply-To: <20130605210104.GQ3803@titan.lakedaemon.net>
References: <1370415901-4721-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130605210104.GQ3803@titan.lakedaemon.net>
Message-ID: <20130606180201.GM23859@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 05, 2013 at 05:01:04PM -0400, Jason Cooper wrote:
> On Wed, Jun 05, 2013 at 09:04:53AM +0200, Thomas Petazzoni wrote:
> > This patch series is based on jcooper/mvebu/fixes-non-critical and
> > jcooper/mvebu/cleanup, which contains 3 patches that are necessary to
> > make this patch series work properly.
> 
> Thomas,
> 
> I've tentatively pulled your series into mvebu/regmap with appropriate
> dependencies.
> 
> I was going to put this in for-next, but I got a build error after
> merging it.  Could you do me a favor and try merging this with
> mvebu/seb_clk?  Just shoot me the merge resolution that builds
> mvebu_defconfig correctly, and I'll incorporate it into the merge.  No
> need to rebase the series.
> 
> If you want to reproduce what I saw, just merge mvebu/regmap with
> for-next (up shortly), and build mvebu_defconfig.

This has now been resolved, whole series, with v2 of the one patch is in
mvebu/regmap.

thx,

Jason.
