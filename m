From: tj@kernel.org (Tejun Heo)
Date: Tue, 19 Jan 2016 12:26:50 -0500
Subject: [PATCH v2] drivers: ata: wake port before DMA stop for ALPM
In-Reply-To: <569D7A7B.8090603@broadcom.com>
References: <1452547346-31735-1-git-send-email-dpetigara@broadcom.com>
 <569D7A7B.8090603@broadcom.com>
Message-ID: <20160119172650.GR3520@mtj.duckdns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 18, 2016 at 03:51:23PM -0800, Danesh Petigara wrote:
> Hi Tejun,
> 
> I was wondering if you had an opportunity to review this patch? Any
> chance of this going into v4.5 along with the other patches, or would
> you like to defer it to v4.6? I am fine either way.

Looks fine to me.  I'll route it through for-4.5-fixes once -rc1 is
cut.

Thanks.

-- 
tejun
