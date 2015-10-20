From: baruch@tkos.co.il (Baruch Siach)
Date: Tue, 20 Oct 2015 14:14:47 +0300
Subject: [PATCH 6/7] clocksource: digicolor: don't trace
 digicolor_timer_sched_read()
In-Reply-To: <1445328160-402-7-git-send-email-jszhang@marvell.com>
References: <1445328160-402-1-git-send-email-jszhang@marvell.com>
 <1445328160-402-7-git-send-email-jszhang@marvell.com>
Message-ID: <20151020111447.GB20889@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jisheng Zhang,

On Tue, Oct 20, 2015 at 04:02:39PM +0800, Jisheng Zhang wrote:
> We should not trace digicolor_timer_sched_read() function, add notrace
> attribute to this function.
> 
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>

Acked-by: Baruch Siach <baruch@tkos.co.il>

Thanks,
baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
