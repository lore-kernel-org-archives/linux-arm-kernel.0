From: baruch@tkos.co.il (Baruch Siach)
Date: Tue, 16 Aug 2011 08:19:18 +0300
Subject: [PATCH] ARM: tegra: Add missing include of linux/erron.h and
	linux/types.h
In-Reply-To: <1313471744.5824.2.camel@phoenix>
References: <1313471744.5824.2.camel@phoenix>
Message-ID: <20110816051918.GA19435@sapphire.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Axel,

On Tue, Aug 16, 2011 at 01:15:44PM +0800, Axel Lin wrote:
> Include linux/erron.h to fix below build error.

s/erron/errno/ here, and in the subject.

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
