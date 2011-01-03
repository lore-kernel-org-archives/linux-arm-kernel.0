From: claude.youn@gmail.com (Seungwhan Youn)
Date: Mon, 3 Jan 2011 10:37:29 +0900
Subject: [alsa-devel] [PATCH 1/4] ARM: Kconfig: Add audio support
	dependency
In-Reply-To: <20110102140517.GJ4935@opensource.wolfsonmicro.com>
References: <1293171965-24416-1-git-send-email-sw.youn@samsung.com>
	<1293172569-21465-1-git-send-email-sw.youn@samsung.com>
	<20110102140517.GJ4935@opensource.wolfsonmicro.com>
Message-ID: <AANLkTinnzD+cB6QuFJ4NK+-ASLDoTw6EgJiXJBreuzTD@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 2, 2011 at 11:05 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Fri, Dec 24, 2010 at 03:36:09PM +0900, Seungwhan Youn wrote:
>
>> This patch adds Samsung ASoC audio support dependency for Samsung SoCs.
>
>> Signed-off-by: Seungwhan Youn <sw.youn@samsung.com>
>
>> + ? ? select ASOC_SAMSUNG if SND_SOC
>
> Hrm, if we're going to do this we probably ought to be doing it for all
> architectures. ?It's a good idea, we don't tend to have multiple
> possible architectures supported for a given architecture. ?Since the
> second patch didn't apply I'll leave this one too, and patches 3 and 4,
> though they all look good.

Yes, I think so, but I didn't think that far when I made these
patches. If you don't mind, can I re-make this patch-set for all
architectures with your 'Requested-by'?
