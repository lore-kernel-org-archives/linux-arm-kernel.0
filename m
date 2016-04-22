From: ynorov@caviumnetworks.com (Yury Norov)
Date: Sat, 23 Apr 2016 00:59:18 +0300
Subject: [PATCH 12/25] arm64: compat: change config dependences to aarch32
In-Reply-To: <20160422155818.GP2998@e104818-lin.cambridge.arm.com>
References: <1459894127-17698-1-git-send-email-ynorov@caviumnetworks.com>
 <1459894127-17698-13-git-send-email-ynorov@caviumnetworks.com>
 <20160422155818.GP2998@e104818-lin.cambridge.arm.com>
Message-ID: <20160422215918.GB2234@yury-N73SV>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 22, 2016 at 04:58:18PM +0100, Catalin Marinas wrote:
> On Wed, Apr 06, 2016 at 01:08:34AM +0300, Yury Norov wrote:
> > From: Bamvor Jian Zhang <bamvor.zhangjian@linaro.org>
> > 
> > With the patches of ILP32, COMPAT is not equivalent to AARCH32 in EL0.
> > This patch fix this by updating the dependency from COMPAT to
> > AARCH32_EL0 for ARMV8_DEPRECATED and ARM64_ERRATUM_845719.
> > 
> > Signed-off-by: Bamvor Jian Zhang <bamvor.zhangjian@linaro.org>
> > Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
> 
> Can you not merge patches 10-12 into a single one? They all deal with
> the s/COMPAT/AARCH32_EL0/ replacement. I'm not even sure the series is
> bisectable after patch 10.
> 
> -- 
> Catalin

 OK, if Bamvoor is not objecting
 
