From: leon@leon.nu (Leon Romanovsky)
Date: Tue, 19 Jun 2012 09:29:58 +0300
Subject: [PATCH 2/2] sound: tegra_alc5632: Adjust to of_get_named_gpio()
 change
In-Reply-To: <CAAAP30G1qzDn+NKT1is+GJ9K2DS3Sm3QY+=n7s-P-Rop2b7FPQ@mail.gmail.com>
References: <1340037743-12924-1-git-send-email-stigge@antcom.de>
 <1340037743-12924-2-git-send-email-stigge@antcom.de>
 <CAAAP30G1qzDn+NKT1is+GJ9K2DS3Sm3QY+=n7s-P-Rop2b7FPQ@mail.gmail.com>
Message-ID: <CALq1K=LXVqfiyrLjn+_p+NTU3X5RjyQzvKdVRf09zXk-RqbkrQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 18, 2012 at 8:28 PM, Alexandre Pereira da Silva
<aletes.xgr@gmail.com> wrote:
> On Mon, Jun 18, 2012 at 1:42 PM, Roland Stigge <stigge@antcom.de> wrote:
>> of_get_named_gpio() was changed to return -EPROBE_DEFER in case of
>> gpios not probed yet. This patch adjusts tegra_alc5632 to this.
>>
>> Signed-off-by: Roland Stigge <stigge@antcom.de>
> Acked-by: Alexandre Pereira da Silva <aletes.xgr@gmail.com>
Hi Alexandre,
Sorry to be rude, but can you explain me why did you "Acked-by" on this patch ?
I don't see your name in git log for tegra_alc5632.c file:
http://git.kernel.org/?p=linux/kernel/git/broonie/sound.git;a=history;f=sound/soc/tegra/tegra_alc5632.c;h=d684df294c0c5c80458b6de591c16965027db14b;hb=refs/heads/for-next

Thanks.

-- 
Leon Romanovsky | Independent Linux Consultant
? ? ? ??www.leon.nu?| leon at leon.nu
