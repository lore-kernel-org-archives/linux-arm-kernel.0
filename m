From: eric@anholt.net (Eric Anholt)
Date: Mon, 19 Sep 2016 11:07:17 +0100
Subject: [PATCH v4 1/7] pinctrl: bcm2835: add pull defines to dt bindings
In-Reply-To: <1474274603-24215-2-git-send-email-kraxel@redhat.com>
References: <1474274603-24215-1-git-send-email-kraxel@redhat.com>
 <1474274603-24215-2-git-send-email-kraxel@redhat.com>
Message-ID: <87zin49p9m.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Gerd Hoffmann <kraxel@redhat.com> writes:

> Also delete (unused) private enum from driver.
> The pull defines can be used instead if needed.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Acked-by: Eric Anholt <eric@anholt.net>

gpio maintainers, could I pull this through my dt tree?  Or does this
need to be split in two?

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 800 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160919/82c39ac2/attachment.sig>
