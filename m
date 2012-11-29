From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 29 Nov 2012 11:57:10 +0100
Subject: [PATCH] ARM: sunxi: Add missing sun4i.dtsi file
In-Reply-To: <201211261823.52160.arnd@arndb.de>
References: <1353941172-26121-1-git-send-email-sr@denx.de>
 <201211261823.52160.arnd@arndb.de>
Message-ID: <50B73F86.9080203@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Le 26/11/2012 19:23, Arnd Bergmann a ?crit :
> On Monday 26 November 2012, Stefan Roese wrote:
>> Patch f055f1f6 [ARM: sunxi: Add sun4i and cubieboard support] missed
>> this sun4i.dtsi include file. This patch finally brings it upstream
>> enabling support for sun4i boards.
>>
>> Signed-off-by: Stefan Roese <sr@denx.de>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
>> ---
>> Arnd, I missed adding this include dtsi file in my last
>> cubieboard/sun4i support patch. Please add this patch
>> to your v3.8 branch.
> 
> Hi Stefan,
> 
> I've added it to the next/soc branch that contains the earlier patches.
> When you submit a patch for inclusion please always address both Olof
> and me, or cc the arm at kernel.org address that forwards to both of us.
> 
> It is also helpful to get patches for one platform only from one person.
> I assume that Maxime is ok with you sending the patch this way, but
> it would be clearer if you send it to him to forward it here, or
> get an 'Acked-by:' tag from him before you send the patch for inclusion.

I'm definitely okay with the change, but yes, I'd prefer to be kept in
the loop :)

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
