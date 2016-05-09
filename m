From: jamesjj.liao@mediatek.com (James Liao)
Date: Mon, 9 May 2016 13:37:26 +0800
Subject: [PATCH v7 8/9] clk: mediatek: Add config options for MT2701
 subsystem clocks
In-Reply-To: <20160506230214.GH3492@codeaurora.org>
References: <1460621514-65191-1-git-send-email-jamesjj.liao@mediatek.com>
 <1460621514-65191-9-git-send-email-jamesjj.liao@mediatek.com>
 <20160506230214.GH3492@codeaurora.org>
Message-ID: <1462772246.5344.4.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HI Stephen,

On Fri, 2016-05-06 at 16:02 -0700, Stephen Boyd wrote:
> On 04/14, James Liao wrote:
> > MT2701 subsystem clocks are optional and should be enabled only if
> > their subsystem drivers are ready to control these clocks.
> > 
> > Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
> > ---
> 
> Why is this patch split off from the patch that introduces the
> file?

I was looking for comments about how to make subsystem clocks optional.
So I used a separated patch to do it. Is it an acceptable way to use
config options to enable subsystem clock support?


Best regards,

James
