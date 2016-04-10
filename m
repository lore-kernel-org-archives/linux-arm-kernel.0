From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Sun, 10 Apr 2016 10:46:50 +0200
Subject: [PATCH 1/2] mfd: max77693: Allow building as a module
In-Reply-To: <20160408071721.GE3323@x1>
References: <1459756459-22061-1-git-send-email-k.kozlowski@samsung.com>
 <20160407132947.GB3323@x1> <20160408035445.GA9532@kozik-lap>
 <20160408071721.GE3323@x1>
Message-ID: <20160410084650.GB9519@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 08, 2016 at 08:17:21AM +0100, Lee Jones wrote:
> > Yes, this can be taken as is. Only second patch (changing defconfig)
> > depends on this. I can take the second patch through samsung tree but
> > that would require a tag/branch with this... which looks like an
> > overkill. So maybe you would take both?
> 
> If I take the defconfig patch without a tag, there will almost
> certainly be merge conflicts.  Other solutions include; delaying the
> defconfig patch for one cycle or trying to get it in post -rc1.

Let's wait for next cycle then. Anyway Javier added module-capability
to some other drivers as well so we can change all them at once.

Best regards,
Krzysztof
