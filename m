From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 1 Mar 2016 09:38:30 +0100
Subject: linux-next: manual merge of the clk tree with the arm-soc tree
In-Reply-To: <20160301150054.2cb0e728@canb.auug.org.au>
References: <20160301145700.784f5fcf@canb.auug.org.au>
 <20160301150054.2cb0e728@canb.auug.org.au>
Message-ID: <56D55506.4050007@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 01/03/2016 05:00, Stephen Rothwell a ?crit :
> Hi all,
> 
> On Tue, 1 Mar 2016 14:57:00 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>
>> Today's linux-next merge of the clk tree got a conflict in:
>>
>>   drivers/clk/at91/clk-main.c
>>
>> between commit:
>>
>>   99a81706526f ("clk: at91: remove IRQ handling and use polling")
>>
>> from the arm-soc tree and commit:
>>
>>   8c1b1e54faed ("clk: at91: Remove impossible checks for of_clk_get_parent_count()")
>>
>> from the clk tree.
> 
> And the same for drivers/clk/at91/clk-master.c

Stephen,

Both fixes seem good. Thanks!

Bye,
-- 
Nicolas Ferre
