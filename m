From: sre@debian.org (Sebastian Reichel)
Date: Tue, 29 Oct 2013 02:06:08 +0100
Subject: [PATCHv2 1/3] Input: twl4030-keypad - add device tree support
In-Reply-To: <5137C017-2515-427C-865F-B938CC24B210@codeaurora.org>
References: <1382446042-27099-1-git-send-email-sre@debian.org>
 <1382446042-27099-2-git-send-email-sre@debian.org>
 <5137C017-2515-427C-865F-B938CC24B210@codeaurora.org>
Message-ID: <20131029010608.GA5353@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 28, 2013 at 01:42:47AM -0500, Kumar Gala wrote:
> > +This binding is based on the matrix-keymap binding with the following
> > +changes:
> 
> Maybe be a bit more specific and say 'based on the input/matrix-keymap.txt binding'..

OK.

> > + * keypad,num-rows and keypad,num-columns are required.
> 
> Is linux,keymap required from matrix-keymap.txt?

Yes, matrix-keymap.txt contains descriptions for the following:

required:
 - linux,keymap
optional:
 - keypad,num-rows
 - keypad,num-columns

> > +Optional Properties specific to linux:
> > +- linux,keypad-no-autorepeat: do no enable autorepeat feature.
> 
> Does it make sense to update the matrix-keymap.txt binding to add
> 'linux,keypad-no-autorepeat' there?

At least according to devicetree documentation there are
keymap-matrix.txt based drivers, which do not support
"linux,keypad-no-autorepeat".

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131029/c6090ce8/attachment-0001.sig>
