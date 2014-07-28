From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 28 Jul 2014 16:43:20 +0200
Subject: [PATCH v15 00/12] enable Hisilicon HiP04
In-Reply-To: <1406555876-11989-1-git-send-email-haojian.zhuang@linaro.org>
References: <1406555876-11989-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <23632622.GF2KGNpINY@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 28 July 2014 21:57:44 Haojian Zhuang wrote:
> Changelog:
> v15:
>   * Add p04 debug uart back.
>   * Refresh since hix5hd2 code updated.
> 

Looks fine to me overall. One small comment from my side, otherwise
please send a pull request once the GIC driver changes have sufficent
Acks. I'll be on vacation starting on Wednesday, so it will likely be
up to Olof to decide whether to merge this for 3.17 or 3.18 depending
on the timing.

	Arnd
