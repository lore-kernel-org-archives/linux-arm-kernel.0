From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Wed, 02 Mar 2011 22:44:14 +0100
Subject: [patch 1/1] t5325: add audio support
In-Reply-To: <alpine.LFD.2.00.1103021556350.16531@xanadu.home> (Nicolas
	Pitre's message of "Wed, 02 Mar 2011 15:58:14 -0500 (EST)")
References: <20110118072802.620728772@rtp-net.org>
	<87tyflw98o.fsf@lebrac.rtp-net.org>
	<alpine.LFD.2.00.1103021556350.16531@xanadu.home>
Message-ID: <87pqq9w635.fsf@lebrac.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nicolas Pitre <nico@fluxnic.net> writes:

Hi,

> On Wed, 2 Mar 2011, Arnaud Patard wrote:
>
>> Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org> writes:
>> 
>> Hi,
>> 
>> > This patch declares the i2c audio codec and initialise audio.
>> > It's adding the alc5621 codec in the i2c board info and is calling
>> > kirkwood_audio_init() to initialize kirkwood audio.
>> 
>> Please, can someone tell me what's wrong in this patch ? I'd like to see
>> this patch merged so if something needs to be fixed, please tell it to
>> me.
>
> I don't know.  Could you make sure it still applies to the latest tree 
> and repost it?

Done. Thanks a lot.

Arnaud
