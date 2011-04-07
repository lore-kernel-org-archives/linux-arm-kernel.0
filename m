From: holler@ahsoftware.de (Alexander Holler)
Date: Thu, 07 Apr 2011 23:31:08 +0200
Subject: [PATCH 1/2] ARM: Differentiate SheevaPlugs and DockStars on the
	basis of the memory size.
In-Reply-To: <toa078-0do.ln1@chipmunk.wormnet.eu>
References: <1302122121-3652-1-git-send-email-holler@ahsoftware.de>
	<1302122121-3652-2-git-send-email-holler@ahsoftware.de>
	<alpine.LFD.2.00.1104061739100.28032@xanadu.home>
	<4D9CED15.2010806@ahsoftware.de>
	<alpine.LFD.2.00.1104061850410.28032@xanadu.home>
	<4D9CF5B3.9020007@ahsoftware.de>
	<toa078-0do.ln1@chipmunk.wormnet.eu>
Message-ID: <4D9E2D1C.7070102@ahsoftware.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 07.04.2011 10:55, schrieb Alexander Clouter:
> In gmane.linux.kernel Alexander Holler<holler@ahsoftware.de>  wrote:
>>
>> Sorry, I don't feel the need to waste my time prodcuing patches to get
>> them called "abominations". Which means my willingness to post further
>> patches just got below zero.
>>
> In a posting from Nico before you got offended it was explained to you
> *why* it was a Bad Idea(tm) and that that sort of thing simply does not
> work.  As a game, is it really a situation with *zero* probability of
> occuring that someone might produce a kirkwood/Sheeva flavoured board
> with only 128MB RAM?
>
> As well as a willingness to 'produce' patches (which to be frank
> *anyone* can do[1])...the hard part is producing *good* patches.  To
> produce good patches you need to read and understand the wisdom you get
> back from the mailing lists you post to.  If you do not understand the
> reasoning, ask.
>
> This is why you see [PATCHv${BIGNUM}] so often in a number of mailing
> lists.  If you are not willing to accept *everyone*, including yourself,
> writes crap code...well the value of your patches falls below zero.

Requiring a machine ID and the needed stuff to handle that for a board 
which just is using two GPIOs different than another board is why the 
ARM tree exploded. And requiring a machine ID just to follow the rule 
that a machine ID is much better than some pretty unique hw feature is 
in my humble opinion senseless and that the resulting code is more 
readable and better to maintain is a myth.

Sorry that I wanted to help there. Will not try it again.

Regards,

Alexander
