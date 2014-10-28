From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Tue, 28 Oct 2014 12:44:10 +0200
Subject: [PATCH v4 0/5] simplefb: add clock handling code
In-Reply-To: <1413996311-4287-1-git-send-email-hdegoede@redhat.com>
References: <1413996311-4287-1-git-send-email-hdegoede@redhat.com>
Message-ID: <544F737A.7000109@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/10/14 19:45, Hans de Goede wrote:

> Since we seem to have broad agreement on how to move forward with this, I
> would like to ask you to please merge this patch-set for 3.19.
> 
> I know 3.19 is still somewhat ar away, but I would like to submit the u-boot
> side of this to upstream ASAP, so can you please let me know if you plan to 
> take this patch-set for 3.19 soon ?

This series looks fine to me, except patch 3 is missing a description,
and patch 4 makes the desc a continuation of the subject. Each patch
should have a description (independent from subject).

No need to resend, I can cook up something for those, or I can edit the
descs if you provide the text.

So if there are no strong objections, I'll queue this for 3.19.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141028/41aa0d04/attachment-0001.sig>
