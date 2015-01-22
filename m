From: olof@lixom.net (Olof Johansson)
Date: Wed, 21 Jan 2015 17:41:39 -0800
Subject: [GIT PULL] DaVinci EDMA updates for v3.20
In-Reply-To: <1421766325-28293-1-git-send-email-nsekhar@ti.com>
References: <1421766325-28293-1-git-send-email-nsekhar@ti.com>
Message-ID: <20150122014139.GF31815@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 20, 2015 at 08:35:24PM +0530, Sekhar Nori wrote:
> The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:
> 
>   Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v3.20/edma
> 
> for you to fetch changes up to bf92c8471b1db35548482fdc1dbae4c15dcc399b:
> 
>   ARM: common: edma.c: Remove some unused functions (2015-01-14 15:29:40 +0530)
> 
> ----------------------------------------------------------------
> Remove EDMA api from platform_data header file.
> Also, cleans up EDMA header file usage in ASoC
> (acked by Mark).
> This is in preparation for eventual removal
> of arch/arm/common/edma.c
> 
> ----------------------------------------------------------------
> Peter Ujfalusi (3):
>       ASoC: davinci-evm: Do not include edma headers
>       ARM: edma: Rename header file for dmaengine filter function definition
>       ARM: edma: Split up header file to platform_data and API file

I had some comments on this patch. Holding off merging this until that's been
resolved (or, if the answers are right, followed up with an incremental patch
that we can add on top I suppose. :)


-Olof
