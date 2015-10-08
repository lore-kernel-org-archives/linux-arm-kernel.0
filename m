From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 08 Oct 2015 20:50:35 +0200
Subject: [GIT PULL 1/3] Keystone SOC driver updates for 4.4
In-Reply-To: <561698EA.4030707@oracle.com>
References: <1444151960-4941-1-git-send-email-ssantosh@kernel.org>
 <5870815.PiO7rCVXjJ@wuerfel> <561698EA.4030707@oracle.com>
Message-ID: <27586837.4pMcRLWPs5@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 08 October 2015 09:25:14 santosh.shilimkar at oracle.com wrote:
> On 10/8/15 8:41 AM, Arnd Bergmann wrote:
> > On Tuesday 06 October 2015 10:19:18 Santosh Shilimkar wrote:
> >> Couple of patches for ARM Keystone SOC drivers
> >>          - irq affinity bug fix
> >>          - display the firmware name
> >>
> >> ----------------------------------------------------------------
> >> Murali Karicheri (2):
> >>        soc: ti: reset irq affinity before freeing irq
> >>        soc: ti: display firmware file name as part of boot log
> >>
> >>   .../bindings/soc/ti/keystone-navigator-qmss.txt      | 20 +++++++++++++++++++-
> >>   drivers/soc/ti/knav_qmss_acc.c                       |  4 ++++
> >>   drivers/soc/ti/knav_qmss_queue.c                     |  3 +++
> >>   3 files changed, 26 insertions(+), 1 deletion(-)
> >
> > The new text you add to the binding document doesn't really seem to
> > belong in there, so I'm not pulling this until we've discussed how
> > this should be better handled.
> >
> OK. Can you please pick the affinity fix alone?

Sure. Actually this looks like it should go into 4.3, possibly stable.
Can you confirm which kernels need it?

	Arnd
