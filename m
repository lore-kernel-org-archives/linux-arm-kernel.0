From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Mon, 17 Dec 2012 15:07:10 +0100
Subject: devicetree support for efikasb
In-Reply-To: <87licw97nn.fsf@dell.be.48ers.dk> (Peter Korsgaard's message of
 "Mon, 17 Dec 2012 13:37:16 +0100")
References: <20121217075907.GQ24458@pengutronix.de>
 <87licwdikj.fsf@lebrac.rtp-net.org> <87licw97nn.fsf@dell.be.48ers.dk>
Message-ID: <871ueodb75.fsf@lebrac.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Peter Korsgaard <jacmet@sunsite.dk> writes:

>>>>>> "Arnaud" == Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org> writes:
>
> Hi,
>
>  >> - keyboard/touchpad
>
>  Arnaud> Did you try using the white led for 'caps lock' ?
>
> Related to that, what happened to the capsl/numl led triggers? I posted
> a patch for it back in 2010, and I think you did as well some time
> later, and at one time something was pending in MM - But I don't seem to
> find anything in mainline?

When I sent my version, I got some feedback from Samuel that it would be
better to try and use the patches he sent but it didn't work on my
smartbook. iirc, after debugging, what I found was seen by Samuel as a
problem somewhere else which was preventing his patches to work, maybe on
framebuffer side. As I was (am ) using a out of tree fb driver, I
stopped here, hoping that maybe it would be working with the kms one.

On a side note, I thought that Samuel's patches were about to be merged
but from your question, it may be not. Right ?

Arnaud
