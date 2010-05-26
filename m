From: apatard@mandriva.com (Arnaud Patard)
Date: Wed, 26 May 2010 10:25:34 +0200
Subject: [patch 4/5] orion/kirkwood: Add i2s support
In-Reply-To: <alpine.LFD.2.00.1005252025210.24526@xanadu.home> (Nicolas
	Pitre's message of "Tue, 25 May 2010 20:31:00 -0400 (EDT)")
References: <20100525122236.841941526@mandriva.com>
	<20100525122341.443140710@mandriva.com>
	<alpine.LFD.2.00.1005252025210.24526@xanadu.home>
Message-ID: <m34ohvgjcx.fsf@anduin.mandriva.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nicolas Pitre <nico@fluxnic.net> writes:

Hi,

> On Tue, 25 May 2010, apatard at mandriva.com wrote:
>
>> This patch enables support for the i2s controller available on orion/kirkwood platforms
>> 
>> Signed-off-by: Arnaud Patard <apatard@mandriva.com>
>
> The actual Orion processor family has no I2S/audio support.  It would be 
> better if all the audio related stuff was renamed to "kirkwood" and 
> "KIRKWOOD_*" instead.

I've been told there was some orion with audio. As I've never looked at
the orion family in details, I assumed this is right and I've changed the
naming accordingly. I can change again but it would be nice to have an
agreement here. Who's/what's right ? orion can or can not have i2s audio ?


Arnaud
