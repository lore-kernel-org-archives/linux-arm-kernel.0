From: a.zummo@towertech.it (Alessandro Zummo)
Date: Fri, 1 Oct 2010 09:36:37 +0200
Subject: [PATCH 1/2] rtc: avoid checking cpuid in pxa-rtc
In-Reply-To: <1285754535-30802-1-git-send-email-haojian.zhuang@marvell.com>
References: <1285754535-30802-1-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <20101001093637.7ba64c68@linux.lan.towertech.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 29 Sep 2010 18:02:14 +0800
Haojian Zhuang <haojian.zhuang@marvell.com> wrote:

> pxa-rtc is widely used in pxa27x/pxa3xx/pxa93x/pxa95x. Checking cpuid in
> pxa-rtc driver is unnecessary since we assign on-chip device in soc files.

 seems reasonable.

 Acked-by: Alessandro Zummo <a.zummo@towertech.it>


-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Torino, Italy

  http://www.towertech.it
