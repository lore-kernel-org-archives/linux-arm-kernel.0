From: leo.yan@linaro.org (Leo Yan)
Date: Sat, 7 Oct 2017 20:18:02 +0800
Subject: [PATCH 0/2] Add support for Hi6220 coresight
In-Reply-To: <20170901013301.GN21656@codeaurora.org>
References: <1504226835-2115-1-git-send-email-leo.yan@linaro.org>
 <20170901013301.GN21656@codeaurora.org>
Message-ID: <20171007121802.GC23080@leoy-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen, Wei,

On Thu, Aug 31, 2017 at 06:33:01PM -0700, Stephen Boyd wrote:
> On 09/01, Leo Yan wrote:
> > This patch series adds support for coresight on Hi6220; the first patch
> > is to fix coresight PLL so can avoid system hang after we enable
> > coresight, the second patch is to add DT binding according to coresight
> > topology.
> > 
> > The patch has been tested on Hikey; By using OpenCSD snapshot mode, it
> > can successfully decode ETF and ETB trace data.
> > 
> 
> I can take the first one and second one goes through arm-soc?

Could you pick these two patches for Hi6220 coresight enabling for
this merge window? Or need me resend these two patches?

Thanks,
Leo Yan
