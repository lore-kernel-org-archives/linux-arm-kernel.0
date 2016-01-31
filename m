From: sre@kernel.org (Sebastian Reichel)
Date: Sun, 31 Jan 2016 01:24:07 +0100
Subject: 3-color led too bright
In-Reply-To: <20160130200750.GB30429@amd>
References: <20160130200750.GB30429@amd>
Message-ID: <20160131002406.GA21238@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pavel,

On Sat, Jan 30, 2016 at 09:07:50PM +0100, Pavel Machek wrote:
> The indicator 3-color LED in mainline kernel seem to be a bit too
> bright. .. more bright to look at comfortably. I believe it is also
> brighter than in original maemo... I believe I've seen note somewhere
> that hardware may allow too much current to the 3-color led damaging
> hardware... but I can't find the link now.

Safe current limits for the leds are configured in the DTS
(led-cur and max-cur) and can be checked in sysfs. I remember
testing the safety limits when I added them to DT, but the
driver has changed a bit since then.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160131/b074120e/attachment-0001.sig>
