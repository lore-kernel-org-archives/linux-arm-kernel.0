From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Fri, 2 Oct 2015 23:13:03 +0800
Subject: [PATCH v4 0/3] add GPT timer support for mt8173
In-Reply-To: <1443798319-45744-1-git-send-email-yingjoe.chen@mediatek.com>
References: <1443798319-45744-1-git-send-email-yingjoe.chen@mediatek.com>
Message-ID: <1443798783.24788.1.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2015-10-02 at 23:05 +0800, Yingjoe Chen wrote:
> This is based on v4.3-rc1 + clockevents-4.4[1] and James's mediatek-clk
> tree[2].
> 
> Changes compare to previous version[3]:
> - Add more MediaTek SoC to mtk-timer binding
> - Update commit message to better describe the purpose.
> 
> Changes compare to v2[4]:
> - the first two mtk_timer related changes are removed because they are
> replaced/accepted in clockevents tree.
> - Remove 'add 13mhz clock for MT8173' because it is accepted in
> mediatek-clk tree.
> - Kconfig.platforms path change.


Hi Sudeep, Mark,

I just post a new version of this patch. Sorry I forgot to CC you.

Joe.C
