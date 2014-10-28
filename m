From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Tue, 28 Oct 2014 12:52:53 +0200
Subject: [PATCH 3/5] fbdev: sa1100fb: make use of device clock
In-Reply-To: <1414147047-12892-4-git-send-email-dbaryshkov@gmail.com>
References: <1414147047-12892-1-git-send-email-dbaryshkov@gmail.com>
 <1414147047-12892-4-git-send-email-dbaryshkov@gmail.com>
Message-ID: <544F7585.8030708@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/10/14 13:37, Dmitry Eremin-Solenikov wrote:
> Use per-device clock (instead of calling cpufreq_get(0), which can
> return 0 if no cpu frequency driver is selected) to program timings.
> 
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> ---
>  drivers/video/fbdev/sa1100fb.c | 24 +++++++++++++++++-------
>  drivers/video/fbdev/sa1100fb.h |  1 +
>  2 files changed, 18 insertions(+), 7 deletions(-)

I presume this has to be merged with the rest of the patches, so:

Acked-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141028/2606d54c/attachment.sig>
