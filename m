From: emilio@elopez.com.ar (=?ISO-8859-1?Q?Emilio_L=F3pez?=)
Date: Fri, 23 May 2014 10:09:01 -0300
Subject: [PATCH 07/22] clk: sunxi: Fix PLL6 calculation on sun6i
In-Reply-To: <1400831485-28576-8-git-send-email-wens@csie.org>
References: <1400831485-28576-1-git-send-email-wens@csie.org>
 <1400831485-28576-8-git-send-email-wens@csie.org>
Message-ID: <537F486D.9060900@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

El 23/05/14 04:51, Chen-Yu Tsai escribi?:
> The N factor for PLL6 counts from 1 to 32, as specified in the A23
> manual, and shown in Allwinner's original code.

Are you sure about this? The A23 manual I'm looking at has a 5-bit field 
(so 0-31) on 12:8, and the examples count from 0 (eg Factor=0 N=1 ... 
Factor=31 N=32).

Cheers,

Emilio
