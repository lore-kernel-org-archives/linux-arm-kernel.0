From: andy.gross@linaro.org (Andy Gross)
Date: Wed, 14 Jun 2017 15:22:44 -0400
Subject: [GIT PULL] Qualcomm ARM64 Defconfig updates for 4.13
In-Reply-To: <359fea25-b560-56c1-b206-fe30d873ac56@linaro.org>
References: <1497383309-14226-1-git-send-email-andy.gross@linaro.org>
 <359fea25-b560-56c1-b206-fe30d873ac56@linaro.org>
Message-ID: <20170614192244.GA32733@hector.wework.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 14, 2017 at 04:50:50PM +0300, Georgi Djakov wrote:
> On 06/13/2017 10:48 PM, Andy Gross wrote:
> > The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:
> > 
> >   Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)
> > 
> > are available in the git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-arm64-defconfig-for-4.13
> > 
> > for you to fetch changes up to 28fc880f3e0087ca84acf5217a226fe9b4bc57d8:
> > 
> >   arm64: defconfig: Switch to the correct Qualcomm SMD driver (2017-06-05 21:56:20 -0500)
> > 
> > ----------------------------------------------------------------
> > Qualcomm ARM64 Based defconfig Updates for v4.13
> > 
> > * Switch to use the SMD RPMSG driver
> > 
> > ----------------------------------------------------------------
> > Georgi Djakov (1):
> >       arm64: defconfig: Switch to the correct Qualcomm SMD driver
> > 
> >  arch/arm64/configs/defconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> This patch is now obsolete as another similar patch was picked by Olof
> already: https://www.spinics.net/lists/arm-kernel/msg581746.html
> So, no need to pull this.


Not sure how I missed that.  My apologies.  No need to pick this up.

Regards,

Andy
