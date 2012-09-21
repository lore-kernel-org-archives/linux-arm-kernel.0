From: olof@lixom.net (Olof Johansson)
Date: Thu, 20 Sep 2012 19:58:22 -0700
Subject: [GIT PULL] ARM: tegra: switch to dmaengine
In-Reply-To: <1347897744-8009-1-git-send-email-swarren@wwwdotorg.org>
References: <1347897744-8009-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20120921025822.GB19276@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 17, 2012 at 10:02:24AM -0600, Stephen Warren wrote:
> The Tegra code-base has contained both a legacy DMA and a dmaengine
> driver since v3.6-rcX. This series flips Tegra's defconfig to enable
> dmaengine rather than the legacy driver, and removes the legacy driver
> and all client code.
> 
> The branch is based on v3.6-rc6 in order to pick up a bug-fix to the
> ASoC Tegra PCM driver that's required for audio to work correctly when
> using dmaengine.
> 
> ----------------------------------------------------------------
> 
> The following changes since commit 5698bd757d55b1bb87edd1a9744ab09c142abfc2:
> 
>   Linux 3.6-rc6
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-tegra.git tegra-for-3.7-dmaengine

Pulled, into tegra/dmaengine-removal (next/cleanup).

Thanks,

-Olof
