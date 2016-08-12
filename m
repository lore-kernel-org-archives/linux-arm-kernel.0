From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 12 Aug 2016 14:11:44 +0530
Subject: [PATCH] phy: sun9i-usb: fix error handling
In-Reply-To: <CAGb2v64D-AcrG8Xot79_7PnUKFnHonU65Crfw7QONj_TFLwv5A@mail.gmail.com>
References: <1467784806-17091-1-git-send-email-christophe.jaillet@wanadoo.fr>
 <CAGb2v64D-AcrG8Xot79_7PnUKFnHonU65Crfw7QONj_TFLwv5A@mail.gmail.com>
Message-ID: <57AD8BC8.7090609@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Wednesday 06 July 2016 11:36 AM, Chen-Yu Tsai wrote:
> On Wed, Jul 6, 2016 at 2:00 PM, Christophe JAILLET
> <christophe.jaillet@wanadoo.fr> wrote:
>> This is likely that checking 'phy->hsic_clk' instead of 'phy->clk' is
>> expected here.
>>
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> 
> Acked-by: Chen-Yu Tsai <wens@csie.org>

merged, thanks

-Kishon
