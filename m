From: eduardo.valentin@ti.com (Eduardo Valentin)
Date: Mon, 6 May 2013 18:40:53 -0400
Subject: [RESEND][PATCH 1/3] arm: dts: introduce config HAS_BANDGAP
In-Reply-To: <20130506213413.GH5634@blackmetal.musicnaut.iki.fi>
References: <1367874058-2378-1-git-send-email-eduardo.valentin@ti.com>
 <1367874058-2378-2-git-send-email-eduardo.valentin@ti.com>
 <20130506213413.GH5634@blackmetal.musicnaut.iki.fi>
Message-ID: <51883175.8010001@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06-05-2013 17:34, Aaro Koskinen wrote:
> On Mon, May 06, 2013 at 05:00:56PM -0400, Eduardo Valentin wrote:
>> Introduce HAS_BANDGAP config entry. This config is a
>> boolean value so that arch code can flag is they
>> feature a bandgap device.
> 
> Maybe it could be mentioned that omap-thermal already depend on this?
> At least for a random reviewer it was not immediately clear why this is
> added, especially since there were no users for it in subsequent patches.
> 
> A.
> 
> 
The flag has been proposed here [1]. The adaptation on the driver has
been introduced here [2,3]. It has reached the staging (next) tree. That
is why you do not see any follow up patch. Although it does not have
users at v3.9, the patch on the user has been sent several weeks ago.

[1] -
http://lists.infradead.org/pipermail/linux-arm-kernel/2012-May/101827.html
[2] - http://marc.info/?l=linux-omap&m=136335347305197&w=2
[3] - http://marc.info/?l=linux-driver-devel&m=136335404205514&w=1

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 295 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130506/c78e1c7b/attachment.sig>
