From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 23 Mar 2013 14:31:40 -0400
Subject: [PATCH v2 00/14] Marvell EBU thermal sensor consolidation
In-Reply-To: <514DF463.5040506@gmail.com>
References: <1363991114-4225-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130323181638.GN13280@titan.lakedaemon.net>
 <514DF463.5040506@gmail.com>
Message-ID: <20130323183140.GO13280@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 23, 2013 at 07:28:51PM +0100, Sebastian Hesselbarth wrote:
> On 03/23/2013 07:16 PM, Jason Cooper wrote:
> >On Fri, Mar 22, 2013 at 07:25:00PM -0300, Ezequiel Garcia wrote:
> >...
> >>Ezequiel Garcia (14):
> >>   thermal: Rename driver 'kirkwood' ->  'mvebu'
> >>   thermal: mvebu: Rename symbols 'kirkwood' ->  'mvebu'
> >>   thermal: mvebu: Move MODULE_DEVICE_TABLE upwards
> >>   thermal: mvebu: Remove unneeded variable initialization
> >>   thermal: mvebu: Convert to devm_ioremap_resource()
> >>   thermal: mvebu: Fix license declaration
> >>   thermal: mvebu: Rename kirkwood definitions to mvebu
> >>   thermal: mvebu: Add infrastructure to support more multiple SoC
> >>     variants
> >>   thermal: mvebu: Add support for Armada XP thermal sensor
> >>   thermal: mvebu: Add support for Armada 370 thermal sensor
> >>   thermal: mvebu: Add support for Marvell Dove SoC family
> >
> >Once the thermal maintainers agree to take this in, I'll take the three

^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Was I not clear?

> >below through mvebu/arm-soc.  This shouldn't cause any dependency
> >headaches, and will reduce the possibility of merge conflicts.
> 
> NACK. This patch set breaks thermal on Dove. I sent a mail earlier.

thx,

Jason.
