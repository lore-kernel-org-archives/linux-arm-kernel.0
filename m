From: saeed.bishara@gmail.com (saeed bishara)
Date: Sun, 3 Jul 2011 11:41:19 +0300
Subject: [PATCH] genirq: replace irq_gc_ack with {set,clr}_bit variants
In-Reply-To: <20110702123554.GK31228@kw.sim.vm.gnt>
References: <20110630095223.GH31228@kw.sim.vm.gnt>
	<1309469952-32242-1-git-send-email-simon@sequanux.org>
	<20110702123554.GK31228@kw.sim.vm.gnt>
Message-ID: <CAMAG_eesTRqOzOPbg=OqFLdiXZJvjFtTCPfZJTsoBJ34=JoDiw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 2, 2011 at 3:35 PM, Simon Guinot <simon@sequanux.org> wrote:
> Hi Thomas, Nicolas, Lennert and Saeed,
>
> On Thu, Jun 30, 2011 at 11:39:12PM +0200, Simon Guinot wrote:
>> From: Simon Guinot <sguinot@lacie.com>
>>
>> This patch fix the edge GPIO interrupts support for Orion based SoCs.
well, thet patch seems to touch non orion based SoCs (davinci, samsung).
>> For this devices, edge interrupt acknowledgement is done by clearing a
>> cause register. Replace irq_gc_ack with {set,clr}_bit variants allows
>> to address such cases.
>>
saeed
