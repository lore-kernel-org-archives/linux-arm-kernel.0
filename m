From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sat, 19 Apr 2014 18:16:32 +0200
Subject: [PATCH 14/29] ARM: orion: switch to a per-platform handle_irq()
 function
In-Reply-To: <20140419140447.4f443551@skate>
References: <1397400006-4315-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1397400006-4315-15-git-send-email-thomas.petazzoni@free-electrons.com>
 <534BBB30.5090602@gmail.com> <20140419092708.78eb9274@skate>
 <53523D40.4080703@gmail.com> <20140419140447.4f443551@skate>
Message-ID: <5352A160.7090905@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/19/2014 02:04 PM, Thomas Petazzoni wrote:
> Dear Sebastian Hesselbarth,
>>> Also, this approach goes towards the goal of reducing plat-orion/ code.
>>> Having the code closer to each SoC is going to make it easier to
>>> progressively get rid of it I believe.
>>
>> Ok, I agree. But IIRC the multi-irq handler is only needed, if you
>> compile both DT and non-DT in one kernel, right?
> 
> Correct.
> 
>> Dove DT just left mach-dove, so there is no way you can compile both.
>> For the sake of simplicity, I'd even agree on adding it now and
>> remove it later again. But at least for Dove, the move is bogus.
> 
> I think there's a lot of possible following clean up to be made. But we
> have to define some limits to the current patch series, otherwise it's
> going to grow to a 50+ patches monster that will be very hard to merge.
> I clearly agree some of things are not in their final ideal state, but
> I believe, overall, this patch series for Orion5x is pushing things in
> the right direction, no?

Agreed, the patch set is a great step for Orion5x. Let's do proper
cleanup afterwards. Thanks for working on it!

Sebastian
