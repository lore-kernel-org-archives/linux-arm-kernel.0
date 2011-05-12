From: ralf@linux-mips.org (Ralf Baechle)
Date: Thu, 12 May 2011 22:57:46 +0100
Subject: [PATCH] fix build warnings on defconfigs
In-Reply-To: <1302375858-11253-1-git-send-email-wanlong.gao@gmail.com>
References: <1302375858-11253-1-git-send-email-wanlong.gao@gmail.com>
Message-ID: <20110512215746.GB21865@linux-mips.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 10, 2011 at 03:04:18AM +0800, wanlong.gao at gmail.com wrote:

> Subject: [PATCH] fix build warnings on defconfigs
> 
> From: Wanlong Gao <wanlong.gao@gmail.com>
> 
> Change the BT_L2CAP and BT_SCO defconfigs from 'm' to 'y',
> since BT_L2CAP and BT_SCO had changed to bool configs.
> 
> Signed-off-by: Wanlong Gao <wanlong.gao@gmail.com>

I've queued the MIPS bits only for 2.6.40.  Thanks.

  Ralf
