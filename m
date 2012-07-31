From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Tue, 31 Jul 2012 10:58:33 +0200
Subject: [PATCH 3/6] mv643xx.c: Add basic device tree support.
In-Reply-To: <50179B31.1000202@codethink.co.uk> (Ian Molton's message of "Tue,
 31 Jul 2012 09:45:37 +0100")
References: <1343661359-10150-1-git-send-email-ian.molton@codethink.co.uk>
 <1343661359-10150-4-git-send-email-ian.molton@codethink.co.uk>
 <87obmw5rm9.fsf@lebrac.rtp-net.org> <50179528.2020801@codethink.co.uk>
 <20120731082742.GU18016@lunn.ch> <50179B31.1000202@codethink.co.uk>
Message-ID: <87k3xk5mti.fsf@lebrac.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ian Molton <ian.molton@codethink.co.uk> writes:

> On 31/07/12 09:27, Andrew Lunn wrote:
>> On Tue, Jul 31, 2012 at 09:19:52AM +0100, Ian Molton wrote:
>>> Are you sure this is required? It can always be added if anything
>>> actually uses it :)
>> Hi Ian
>>
>> Try using jumbo packets on kirkwood.
>>
>> http://comments.gmane.org/gmane.linux.ports.arm.kernel/178785
>> http://www.spinics.net/lists/arm-kernel/msg186152.html
>
> Ah, this postdates the D-T branches on which I am working being forked.

the original patch was from years ago but I noticed only recently it was
still not merged and sent this patch. I asked about it on DT because I
don't want it to get lost again, even if it looks like not a lot of
people are using jumbo frames on kirkwood or dove.

>
> I'll fold this into my patchset.

Thanks,
Arnaud
