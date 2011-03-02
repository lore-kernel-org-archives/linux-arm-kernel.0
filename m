From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 02 Mar 2011 15:58:14 -0500 (EST)
Subject: [patch 1/1] t5325: add audio support
In-Reply-To: <87tyflw98o.fsf@lebrac.rtp-net.org>
References: <20110118072802.620728772@rtp-net.org>
	<87tyflw98o.fsf@lebrac.rtp-net.org>
Message-ID: <alpine.LFD.2.00.1103021556350.16531@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2 Mar 2011, Arnaud Patard wrote:

> Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org> writes:
> 
> Hi,
> 
> > This patch declares the i2c audio codec and initialise audio.
> > It's adding the alc5621 codec in the i2c board info and is calling
> > kirkwood_audio_init() to initialize kirkwood audio.
> 
> Please, can someone tell me what's wrong in this patch ? I'd like to see
> this patch merged so if something needs to be fixed, please tell it to
> me.

I don't know.  Could you make sure it still applies to the latest tree 
and repost it?


Nicolas
