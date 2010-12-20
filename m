From: nsekhar@ti.com (Nori, Sekhar)
Date: Mon, 20 Dec 2010 17:10:30 +0530
Subject: [PATCH v4 1/2 (REPOST)] davinci: am18x/da850/omap-l138: add
	support for higher speed grades
In-Reply-To: <4D0F3357.8060905@mvista.com>
References: <1292840911-16325-1-git-send-email-nsekhar@ti.com>
	<4D0F3357.8060905@mvista.com>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB5930247ECB732@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 20, 2010 at 16:13:35, Sergei Shtylyov wrote:
> Hello.
>
> On 20-12-2010 13:28, Sekhar Nori wrote:
>
> > AM18x/DA850/OMAP-L138 SoCs have variants that can operate
> > at a maximum of 456 MHz at 1.3V operating point. Also the
> > 1.2V operating point has a variant that can support a maximum
> > of 375 MHz.
>
> > This patch adds three new OPPs (456 MHz, 408 MHz and 372 MHz)
> > to the list of DA850 OPPs.
>
> > Not all silicon is qualified to run at higher speeds and
> > unfortunately the maximum speed the chip can support can only
> > be determined from the label on the package (not software
> > readable).
>
> > Because of this, we depend on the maximum speed grade information
> > to be provided to us in some board specific way. The board informs
> > the maximum speed grade information to the SoC by calling the
> > da850_set_max_speed() function.
>
>     This sentence no longer applies. You've reduced the function to a variable.

Oops, missed updating this part. Thanks for pointing out.

Regards,
Sekhar
