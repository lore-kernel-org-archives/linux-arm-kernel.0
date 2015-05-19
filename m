From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 19 May 2015 13:35:07 -0700
Subject: [PATCH v4 4/5] clk: hi6220: Clock driver support for Hisilicon
 hi6220 SoC
In-Reply-To: <CAAS=xmjsFoQg-HgWA5-e=cF3qF+PcVNc3i_3Z5EBPNJ2HyOZKQ@mail.gmail.com>
References: <1430827599-11560-1-git-send-email-bintian.wang@huawei.com>	<1430827599-11560-5-git-send-email-bintian.wang@huawei.com>	<20150515002527.GD31753@codeaurora.org>	<5555A37B.1090105@huawei.com>	<20150515193041.GO31753@codeaurora.org>
 <CAAS=xmjsFoQg-HgWA5-e=cF3qF+PcVNc3i_3Z5EBPNJ2HyOZKQ@mail.gmail.com>
Message-ID: <555B9E7B.9000809@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/15/15 19:54, Brent Wang wrote:
>
>>> How about just send this patch for review not the whole patch set in
>>> next version?
>>>
>> Yes a single patch is fine. I take it you want the patch to go
>> through arm-soc with some Ack from us?
> Yes, exactly.
> The dts file includes the clock head file,  this patch goes through
> arm-soc is a good choice.

One way to avoid that problem is to split the clock header file into its
own patch and then duplicate that patch in two trees, one that goes
through arm-soc and one that goes through clk.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
