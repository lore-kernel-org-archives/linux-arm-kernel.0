From: michal.simek@xilinx.com (Michal Simek)
Date: Mon, 5 Nov 2018 14:45:14 +0100
Subject: [PATCH v10 5/6] arm64: zynqmp: Add DDRC node
In-Reply-To: <20181105134218.GD7937@zn.tnic>
References: <1540447621-22870-1-git-send-email-manish.narani@xilinx.com>
 <1540447621-22870-6-git-send-email-manish.narani@xilinx.com>
 <20181105125644.GA7937@zn.tnic>
 <41c5ca53-ed4b-38d0-c612-e1229004293e@xilinx.com>
 <20181105132007.GB7937@zn.tnic>
 <a81f47e0-1778-a6ac-4cd8-634502661d6f@xilinx.com>
 <20181105134218.GD7937@zn.tnic>
Message-ID: <cab338b6-e4d6-0436-6eb8-cbd6c33115f2@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05. 11. 18 14:42, Borislav Petkov wrote:
> On Mon, Nov 05, 2018 at 02:32:55PM +0100, Michal Simek wrote:
>> you don't have that HW anyway.
> 
> Grrr, I'm not talking about me - I'm talking about people testing
> linux-next. And perhaps in this particular case it won't matter because
> this hw is not shipping yet or whatever but the question is about the
> principle of the whole thing.
>
>> I looked at v10 and I can't see your ack there. Can you please give me
>> a link?
> 
> I'm talking about *other* patches for another driver.
> 
> Please note that I'm replying to this thread as an example - the
> procedural question I have is not only related to the synopsys changes
> but the synopsys changes are a good example for the problem of EDAC
> changes being sent to me along with DT additions.
> 
> As such, the question was aimed more at arm-soc people - that's why they
> were in To: - not at you.

ok. Got it.

M
