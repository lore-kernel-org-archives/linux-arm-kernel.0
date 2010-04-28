From: lrg@slimlogic.co.uk (Liam Girdwood)
Date: Wed, 28 Apr 2010 15:22:00 +0100
Subject: [PATCH 01/01] regulator: fix enabling regulator issue on max8925
In-Reply-To: <k2u771cded01004280559s156ff50bnb172767893c89845@mail.gmail.com>
References: <k2u771cded01004280559s156ff50bnb172767893c89845@mail.gmail.com>
Message-ID: <1272464520.3224.492.camel@odin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-04-28 at 08:59 -0400, Haojian Zhuang wrote:
> >From 9f421a29db78635210b29df1d5f83bdc523e3178 Mon Sep 17 00:00:00 2001
> From: Haojian Zhuang <haojian.zhuang@marvell.com>
> Date: Tue, 6 Apr 2010 06:19:15 -0400
> Subject: [PATCH] regulator: fix enabling regulator issue on max8925
> 
> Fix regulator enabling issue that is caused by typo error in is_enabled().
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
> ---
>  drivers/regulator/max8925-regulator.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 

Applied.

Thanks

Liam

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
