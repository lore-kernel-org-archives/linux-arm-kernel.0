From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 13 Nov 2012 16:50:08 +0900
Subject: [RFC PATCH v4 2/2] ASoC: sam9g20-wm8731: convert to dt support
In-Reply-To: <20121108152431.GJ4576@game.jcrosoft.org>
References: <1352361422-13265-1-git-send-email-voice.shen@atmel.com>
 <1352361422-13265-2-git-send-email-voice.shen@atmel.com>
 <20121108152431.GJ4576@game.jcrosoft.org>
Message-ID: <20121113075007.GM18224@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 08, 2012 at 04:24:31PM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 15:57 Thu 08 Nov     , Bo Shen wrote:
> > Signed-off-by: Bo Shen <voice.shen@atmel.com>
> > ---
> > Change since v3 RFC:
> >   Remove dai node, remap ssc in place
> >   without pinctrl added, so don't modify the dtsi file, will be added
> >   soon
> until I see the pinctrl to test this no
> This code is untested

I see a version adding the DT pinmux stuff has now been posted but this
does seem a bit unfair, the code should be fine on a current ASoC branch
- it's only going to break after merging with the pinctrl support.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121113/ee97a681/attachment.sig>
