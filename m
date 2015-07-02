From: balbi@ti.com (Felipe Balbi)
Date: Thu, 2 Jul 2015 08:19:31 -0500
Subject: [PATCH 2/2] ARM: DTS: am437x-sk-evm: Switch using
 simple-audio-card for audio support
In-Reply-To: <55953421.30009@ti.com>
References: <1435838286-30491-1-git-send-email-peter.ujfalusi@ti.com>
 <1435838286-30491-3-git-send-email-peter.ujfalusi@ti.com>
 <20150702122337.GE5837@saruman.tx.rr.com> <55953421.30009@ti.com>
Message-ID: <20150702131931.GH5837@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 02, 2015 at 03:52:49PM +0300, Peter Ujfalusi wrote:
> On 07/02/2015 03:23 PM, Felipe Balbi wrote:
> > On Thu, Jul 02, 2015 at 02:58:06PM +0300, Peter Ujfalusi wrote:
> >> The sound support consist only Headset output on the board and can be
> >> handled by "simple-audio-card"
> >>
> >> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> > 
> > Still works fine:
> > 
> > Tested-by: Felipe Balbi <balbi@ti.com>
> > 
> > one question though, should Line In be listed below ?
> 
> Does the board have Line-in? I don't have the board, but I know this patch

yeah, it does :-)

> works on it ;)
> We only had playback path before also.

indeed, should go for -next only :-s

> > Also, unrelated to
> > $subject, but if I wait for a few seconds between runs of speaker-test
> > (iow, if I allow mcasp to idle) then I hear a slight chopping sound when
> > starting, perhaps we're unmuting too early ?
> 
> Is it only with this patch (via simple-card) or was it the same via the
> davinci-evm (ti,da830-evm-audio)?

/me goes test again

also without this patch :-)

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150702/8b873ad5/attachment.sig>
