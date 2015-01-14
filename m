From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 14 Jan 2015 22:00:19 +0300
Subject: [PATCH] ARM: shmobile: r8a7791: fix MSTP8 input clocks
In-Reply-To: <20150113003604.GB27284@verge.net.au>
References: <4221957.7dd2kFrTHY@wasted.cogentembedded.com>
 <20150113003604.GB27284@verge.net.au>
Message-ID: <54B6BCC3.6040307@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 01/13/2015 03:36 AM, Simon Horman wrote:

>> I made  a mistake when rebasing Andrey Gusakov's patch adding MLB+ clock to the
>> R8A7791 device  tree, inserting <&hp_clk> into the "clocks"  property of the
>> MSTP8 node at a wrong position, so that the input clocks for MLB+ and IPMMU-SGX
>> got swapped...

>> Fixes: 7408d3061d2f ("ARM: shmobile: r8a7791: add MLB+ clock")
>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

>> ---
>> The patch is against 'renesas-devel-20150108v2-v3.19-rc3' tag of Simon Horman's
>> 'renesas.git' repo.

> Thanks, I have queued this up.

    Thank you! I've just noticed that this patch was atop of several other 
patches in my tree, so there might have been an offset when you applied it.
Sorry about that... :-<

WBR, Sergei
