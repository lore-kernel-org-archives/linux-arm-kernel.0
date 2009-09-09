From: jsgood.yang@samsung.com (Jinsung Yang)
Date: Wed, 09 Sep 2009 20:27:46 +0900
Subject: [PATCH 0/4] Fixed keypad driver for Samsung SoC
In-Reply-To: <000d01ca313e$867e7bd0$937b7370$%yang@samsung.com>
References: <000d01ca313e$867e7bd0$937b7370$%yang@samsung.com>
Message-ID: <000f01ca3140$8e48bcc0$aada3640$%yang@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ben,

Also old [PATCH 10/12] must be removed for new [PATCH 4/4].
I'm sorry for your confusion.

Best Regards
--
Jinsung, Yang <jsgood.yang@samsung.com>
AP Development Team
System LSI, Semiconductor Business
SAMSUNG Electronics Co., LTD


> -----Original Message-----
> From: linux-input-owner at vger.kernel.org [mailto:linux-input-
> owner at vger.kernel.org] On Behalf Of Jinsung Yang
> Sent: Wednesday, September 09, 2009 8:13 PM
> To: Dmitry Torokhov; ben-linux at fluff.org
> Cc: linux-input at vger.kernel.org; laforge at gnumonks.org; '???/AP???
> (SYS.LSI)/E3(??)/????'; '???/AP???(SYS.LSI)/E5(??)/????';
> linux-arm-kernel at lists.infradead.org
> Subject: [PATCH 0/4] Fixed keypad driver for Samsung SoC
> 
> From: Jinsung Yang <jsgood.yang@samsung.com>
> 
> To Dmitry:
> This patch series are including new Samsung SoC keypad driver with fixing
> wrong implementations which commented by you.
> All changes and adds are in single patch.
> 
> [PATCH 1/4] [INPUT][KEYBOARD] Samsung keypad driver support
> 
> This patch depends on following architecture patches:
> 
> [PATCH 2/4] [ARM][S3C] Add definition for keypad platform data
> [PATCH 3/4] [ARM][S3C] Add definition for keypad register
> [PATCH 4/4] [ARM][S3C] Add support keypad platform data
> 
> To Ben:
> As you know, I sent to you 12 patches for keypad driver some days ago,
> however I need to change several patch files with following guidance:
> 
> This [PATCH 2/4] must be used instead of old [PATCH 07/12]
> This [PATCH 3/4] must be used instead of old [PATCH 09/12]
> This [PATCH 4/4] must be used instead of old both [PATCH 11/12] and [PATCH
> 12/12]
> 
> Best Regards
> --
> Jinsung, Yang <jsgood.yang@samsung.com>
> AP Development Team
> System LSI, Semiconductor Business
> SAMSUNG Electronics Co., LTD
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
