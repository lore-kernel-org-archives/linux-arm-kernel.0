From: baruch@tkos.co.il (Baruch Siach)
Date: Mon, 9 Dec 2013 12:45:47 +0200
Subject: dw_apb_timer compatible string change
Message-ID: <20131209104547.GC705@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dinh,

In commit 620f5e1cbf (dts: Rename DW APB timer compatible strings) you changed 
the DesignWare APB timer documented compatible string to "dw-apb-timer", and 
deprecated the old ones. This commit went into v3.12 through the ARM SoC tree. 
The driver itself, however, doesn't seems to have been updated to recognize 
this newly documented compatible string as of v3.13-rc3.

Do you know whether there is a patch fixing the driver in some patch queue?

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
