From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Thu, 4 Apr 2013 13:16:08 +0300
Subject: [PATCHv3 0/6] fb: vt8500: patches for 3.10
In-Reply-To: <515D0F5E.5010805@prisktech.co.nz>
References: <1364926838-6721-1-git-send-email-linux@prisktech.co.nz>
 <515D0F5E.5010805@prisktech.co.nz>
Message-ID: <515D52E8.4010206@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2013-04-04 08:27, Tony Prisk wrote:

> Tomi,
> 
> If no one has any further comments, are you still prepared to take this
> series?
> If so, I will send a pull-request.

Yes, I can take it. No need for pull-request, it was simple enough to
apply. I'll push it to linux-next today or tomorrow.

> With regards to the earlier concern about your current patch series, I
> think its easiest if you do take this series then you could do a fixup
> patch if this one is merged first. From what I remember of your series,
> it is basically a rename of of_get_display_timings() to
> of_get_display_timing() and some new code which I don't use. Seems a
> rather trivial patch for a fixup later.

Yes, I can fix it. Should be trivial.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 899 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130404/a56e2ab5/attachment.sig>
