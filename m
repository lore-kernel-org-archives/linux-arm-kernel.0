From: baruch@tkos.co.il (Baruch Siach)
Date: Tue, 11 Jan 2011 09:23:01 +0200
Subject: [PATCH 0/2] ARM i.MX53 enable SMD and LOCO board bootup
In-Reply-To: <1294726998-20830-1-git-send-email-yong.shen@freescale.com>
References: <1294726998-20830-1-git-send-email-yong.shen@freescale.com>
Message-ID: <20110111072301.GA19168@jasper.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yong,

On Tue, Jan 11, 2011 at 02:23:16PM +0800, yong.shen at freescale.com wrote:
> SMD and LOCO are newly developed boards of i.MX53. LOCO means "low cost", 
> which is supposed to be widespread soon.

These two patches seem almost identical. Can't both board support code share 
the same file?

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
