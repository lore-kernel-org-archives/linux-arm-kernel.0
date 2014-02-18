From: emilio@elopez.com.ar (=?ISO-8859-1?Q?Emilio_L=F3pez?=)
Date: Tue, 18 Feb 2014 11:51:31 -0300
Subject: [PATCH v4 0/8] Add Allwinner A20 GMAC ethernet support
In-Reply-To: <20140210194735.GY3192@lukather>
References: <1392028554-32545-1-git-send-email-wens@csie.org>
 <20140210194735.GY3192@lukather>
Message-ID: <53037373.4070701@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

El 10/02/14 16:47, Maxime Ripard escribi?:
> Hi Chen-Yu,
>
> On Mon, Feb 10, 2014 at 06:35:46PM +0800, Chen-Yu Tsai wrote:
>> Hi,
>>
>> This is the v4 of the remaining Allwinner A20 GMAC glue layer patches.
>> The stmmac driver changes have been merged through net-next. The
>> remaining bits are clock and DT patches. The patches should be applied
>> over my clock renaming patches.
>>
>> The Allwinner A20 SoC integrates an early version of dwmac
>> IP from Synopsys. On top of that is a hardware glue layer.
>> This layer needs to be configured before the dwmac can be
>> used.
>>
>> Part of the glue layer is a clock mux, which controls the
>> source and direction of the TX clock used by GMAC.
>
> Just merged patches 2-8.

And I just merged patch 1 on my branch for Mike

Cheers,

Emilio
