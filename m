From: roel.kluin@gmail.com (roel kluin)
Date: Tue, 2 Feb 2010 16:44:20 +0100
Subject: [PATCH v3 2/7 RE-SEND] ARM: S5P6442: Add clock support for
	S5P6442
In-Reply-To: <25e057c01002020741l157f57e3s431716adcf038a83@mail.gmail.com>
References: <1265116976-10140-1-git-send-email-kgene.kim@samsung.com>
	<25e057c01002020741l157f57e3s431716adcf038a83@mail.gmail.com>
Message-ID: <25e057c01002020744h11e0dc8dv1217705e9c776a1a@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 2, 2010 at 4:41 PM, roel kluin <roel.kluin@gmail.com> wrote:
>> This patch adds clock support for S5P6442. This patch adds the clock
>> register definitions and the various system clocks in S5P6442.
>
>> +static struct clksrc_clk clk_mout_epll = {
>> + ? ? ? .clk ? ?= {
>> + ? ? ? ? ? ? ? .name ? ? ? ? ? = "mout_epll",
>> + ? ? ? ? ? ? ? .id ? ? ? ? ? ? = -1,
>> + ? ? ? },
>> + ? ? ? .sources ? ? ? ?= &clk_src_epll,
>> + ? ? ? .reg_src ? ? ? ?= { .reg = S5P_CLK_SRC0, .shift = 8, .size = 1 },
>> +};
>
> This appears not to be used, is this implemented in another patch?

It is, please ignore.

Roel
