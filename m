From: 21cnbao@gmail.com (Barry Song)
Date: Wed, 29 Jul 2015 20:24:12 +0800
Subject: [PATCH 2/7] clk: atlas7: export mux clks so that driver can use it
In-Reply-To: <55B7FAAB.8070801@codeaurora.org>
References: <1438064845-17894-1-git-send-email-21cnbao@gmail.com>
 <1438064845-17894-3-git-send-email-21cnbao@gmail.com>
 <55B7FAAB.8070801@codeaurora.org>
Message-ID: <CAGsJ_4yYyuC3d=LP=cxivFkgDcQj2=ehwnSOHcveOeF3Cd0xfA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-07-29 5:56 GMT+08:00 Stephen Boyd <sboyd@codeaurora.org>:
> On 07/27/2015 11:27 PM, Barry Song wrote:
>> From: Guo Zeng <guo.zeng@csr.com>
>>
>> this patch makes mux clks can be referenced by device drivers.
>>
>> Signed-off-by: Guo Zeng <guo.zeng@csr.com>
>> Signed-off-by: Barry Song <Barry.Song@csr.com>
>> ---
>
> The subject makes this sounds like we're exporting clocks to drivers via
> extern, but that's not happening. Perhaps the subject could be clarified
> to say something like "export mux clks so that consumers can get them"?
>

ok. sounds good.

-barry
