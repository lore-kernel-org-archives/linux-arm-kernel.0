From: lethal@linux-sh.org (Paul Mundt)
Date: Thu, 2 Jun 2011 14:24:52 +0900
Subject: [PATCH] Fix build warning of the defconfigs
In-Reply-To: <1306945763-6583-1-git-send-email-wanlong.gao@gmail.com>
References: <1306945763-6583-1-git-send-email-wanlong.gao@gmail.com>
Message-ID: <20110602052452.GA6087@linux-sh.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 02, 2011 at 12:29:23AM +0800, Wanlong Gao wrote:
> RTC_CLASS is changed to bool.
> So value 'm' is invalid.
> 
> Signed-off-by: Wanlong Gao <wanlong.gao@gmail.com>

>  arch/sh/configs/titan_defconfig            |    2 +-

Acked-by: Paul Mundt <lethal@linux-sh.org>
