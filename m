From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 4 Nov 2009 14:42:09 +0800
Subject: [PATCH 0/3] ezx: A780/A910 camera, A910 leds, ezx_defconfig
	update
In-Reply-To: <20091103214020.a5f6bac9.ospite@studenti.unina.it>
References: <1257266734-28673-1-git-send-email-ospite@studenti.unina.it>
	<20091103174430.GA20822@excalibur.local>
	<20091103214020.a5f6bac9.ospite@studenti.unina.it>
Message-ID: <f17812d70911032242l343008c5y48b35666f6d214d7@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 4, 2009 at 4:40 AM, Antonio Ospite <ospite@studenti.unina.it> wrote:
> On Tue, 3 Nov 2009 18:44:30 +0100
> Stefan Schmidt <stefan@datenfreihafen.org> wrote:
>
>> Hello.
>>
>> [Put Eric in CC]
>>
>
> <OT>
> Thanks, I've realized that the best practice to write the summary
> message is via 'git format-patch --cover-letter' to add the needed
> recipients, rather than using 'git send-email --compose' which doesn't
> process CCs, BCCs and SOBs for the introduction message.
> </OT>
>
>> On Tue, 2009-11-03 at 17:45, Antonio Ospite wrote:
>> >
>> > some updates for the EZX platform:
>>
>> Thanks for driving this forward.
>>
>> > [PATCH 1/3] ezx: Add camera support for A780 and A910 EZX phones
>> > [PATCH 2/3] ezx: Add leds-lp3944 support for A910 EZX phone
>> > [PATCH 3/3] ezx: Update ezx_defconfig now that ezx-pcap is in
>> >
>> > Are we still in time for 2.6.32?
>>
>> Given that we are near -rc6 and this is clearly no fix I would say no. But Eric
>> should be happy to apply it to his devel branch which will hit Linus tree during
>> the next merge window.
>>
>
> That's fine, of course.
>
>> Eric, Antonio is doing a good deal of the current work at OpenEZX. If you need
>> an ACK anyway you can put mine into it.
>>
>> Acked-by: Stefan Schmidt <stefan@datenfreihafen.org>
>>

Thanks Stefan and Antonio,

We are still in -rc phase so will not likely miss the next merge window
once you get the MFP/GPIO issue solved.

BTW: I didn't see [PATCH 3/3], or maybe I overlooked?
