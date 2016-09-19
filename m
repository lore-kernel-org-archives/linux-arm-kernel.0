From: eric@anholt.net (Eric Anholt)
Date: Mon, 19 Sep 2016 11:12:37 +0100
Subject: [PATCH v4 7/7] ARM: dts: bcm283x: drop alt3 from &gpio
In-Reply-To: <1474274603-24215-8-git-send-email-kraxel@redhat.com>
References: <1474274603-24215-1-git-send-email-kraxel@redhat.com>
 <1474274603-24215-8-git-send-email-kraxel@redhat.com>
Message-ID: <87wpi89p0q.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Gerd Hoffmann <kraxel@redhat.com> writes:

> As the alt3 group has no pins left drop it from &gpio.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

If you end up spinning another version for some reason, I'd squash this
patch with the previous one.  But regardless, 3-7 are:

Acked-by: Eric Anholt <eric@anholt.net>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 800 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160919/749771d8/attachment.sig>
