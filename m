From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 23 Jun 2017 10:49:01 +0200
Subject: [PATCH 0/6] Update binding documentation for cp110 and ap806
In-Reply-To: <20170622211456.rip2gveiprlfw3kj@rob-hp-laptop> (Rob Herring's
 message of "Thu, 22 Jun 2017 16:14:56 -0500")
References: <20170620083754.28053-1-gregory.clement@free-electrons.com>
 <87k2463c66.fsf@free-electrons.com>
 <20170622211456.rip2gveiprlfw3kj@rob-hp-laptop>
Message-ID: <87shirytqa.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,


as you were not in CC of the thread here is the reference:
http://lists.infradead.org/pipermail/linux-arm-kernel/2017-June/514497.html

 On jeu., juin 22 2017, Rob Herring <robh@kernel.org> wrote:

> On Tue, Jun 20, 2017 at 05:34:57PM +0200, Gregory CLEMENT wrote:
>> Hi Rob, 
>>  
>>  On mar., juin 20 2017, Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:
>> 
>> > Hi Rob,
>> >
>> > As you know there were dependencies issue about the binding between my
>> > different series and you proposed yourself to apply them though the
>> > device tree subsystem: [1]
>
> I did, but ...
>
>> >
>> > All the driver parts have been merged so it's time merging the
>> > documentation.
>> 
>> I forgot to mentioned that this series is based on the clk-ap806-dt
>> stable branch:
>> 
>> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/log/?h=clk-ap806-dt
>
> ... that was to avoid cross tree dependencies. Now you're creating one. 
> Either Mike should take everything or drop this branch and I'll take it 
> too.

Could you take them all? I can do a PR for this and I take this
opportunity to add the missing ack in pacth 6


Thanks,

Gregory
>
> And you missed my ack on patch 6.
>
> Rob

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
