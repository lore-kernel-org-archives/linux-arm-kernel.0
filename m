From: eric@anholt.net (Eric Anholt)
Date: Mon, 22 May 2017 09:33:19 -0700
Subject: [PATCH 6/7] staging: bcm2835-audio: Deliver indirect-PCM transfer
 error
In-Reply-To: <20170521190258.1178-7-tiwai@suse.de>
References: <20170521190258.1178-1-tiwai@suse.de>
 <20170521190258.1178-7-tiwai@suse.de>
Message-ID: <87tw4cn968.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Takashi Iwai <tiwai@suse.de> writes:

> Now that the indirect-PCM transfer helper gives back an error, we
> should return the error from ack callbacks.

As far as bcm2835 goes:

Acked-by: Eric Anholt <eric@anholt.net>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170522/e51eb81a/attachment.sig>
