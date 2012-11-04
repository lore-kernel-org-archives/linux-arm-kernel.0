From: vaibhav.bedia@ti.com (Bedia, Vaibhav)
Date: Sun, 4 Nov 2012 15:26:11 +0000
Subject: [PATCH 06/15] ARM: OMAP2+: hwmod: Enable OCMCRAM registration
 in AM33XX
In-Reply-To: <5095436E.6030206@ti.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com>
 <1351859566-24818-7-git-send-email-vaibhav.bedia@ti.com>
 <5095436E.6030206@ti.com>
Message-ID: <B5906170F1614E41A8A28DE3B8D121433EBFFD2B@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 03, 2012 at 21:46:46, Shilimkar, Santosh wrote:
> On Friday 02 November 2012 06:02 PM, Vaibhav Bedia wrote:
> > The hwmod data for OCMCRAM in AM33XX was commented out.
> > This data is needed by the power management code, hence
> > uncomment the same and register the OCP interface for it.
> >
> Why this data is needed by PM code ?
> 

It's needed to ensure that the clock to ocmcram is running
during boot and doesn't get disabled as part of the suspend
sequence. Will reword the changelog.

Regards,
Vaibhav
