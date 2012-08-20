From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 20 Aug 2012 16:54:27 +0200
Subject: [PATCH 11/11] arm: mvebu: add pinctrl support in defconfig
In-Reply-To: <CACRpkdaF3OuBLC7odWyH5C_EJT9uFq1rYQMh6=kr8PQjvA68sA@mail.gmail.com>
References: <1344689809-6223-1-git-send-email-sebastian.hesselbarth@gmail.com>	<1344689809-6223-12-git-send-email-sebastian.hesselbarth@gmail.com>
 <CACRpkdaF3OuBLC7odWyH5C_EJT9uFq1rYQMh6=kr8PQjvA68sA@mail.gmail.com>
Message-ID: <50324FA3.9030005@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/20/2012 04:31 PM, Linus Walleij wrote:
> On Sat, Aug 11, 2012 at 2:56 PM, Sebastian Hesselbarth
> <sebastian.hesselbarth@gmail.com>  wrote:
>> +CONFIG_PINCTRL_ARMADA_370=y
>> +CONFIG_PINCTRL_ARMADA_XP=y
>
> If the system is not even booting without pinctrl you should
> (IMHO) select these from the machine's Kconfig entry insteaf.

I don't have a strong opinion on this but I think most systems
will boot just fine without pinctrl. The basic stuff is set up
by u-boot. Anyway, I think we should enable pinctrl for each soc
by default.

Sebastian
