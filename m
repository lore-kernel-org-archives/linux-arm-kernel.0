From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Tue, 7 May 2013 09:48:47 +0800
Subject: [PATCH 2/2] rtc: pxa: add pxa95x rtc support
In-Reply-To: <1367889447-15619-3-git-send-email-chao.xie@marvell.com>
References: <1367889447-15619-1-git-send-email-chao.xie@marvell.com>
 <1367889447-15619-3-git-send-email-chao.xie@marvell.com>
Message-ID: <CAN1soZxQQTQG1CdNGYmCDfddLHWA5HVZ+SWjFhcfidsdGazprw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 7, 2013 at 9:17 AM, Chao Xie <chao.xie@marvell.com> wrote:
> the pxa95x rtc need access PBSR register before write to RTTR, RCNR, RDCR, and RYCR registers.
>
> Signed-off-by: Chao Xie <chao.xie@marvell.com>
> ---

Do we really need this for other SoC? PXA95x is removed already since
it's a block on supporting
multi-platform & not used widely.

Regards
Haojian
