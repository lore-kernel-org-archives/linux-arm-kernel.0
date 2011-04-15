From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 15 Apr 2011 21:02:13 +0200
Subject: [PATCH] atmel_serial: keep the platform_device unchanged
In-Reply-To: <20110413225818.39ce5104@bob.linux.org.uk>
References: <1302724038-26236-1-git-send-email-plagnioj@jcrosoft.com>
	<20110413225818.39ce5104@bob.linux.org.uk>
Message-ID: <20110415190213.GA3981@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22:58 Wed 13 Apr     , Alan Cox wrote:
> On Wed, 13 Apr 2011 21:47:18 +0200
> Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com> wrote:
> 
> > specify the port num via platform_data this will allow to match the
> > clock with the plaform_dev staticly
> > 
> > Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD
> > <plagnioj@jcrosoft.com> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> > Cc: Patrice Vilchez <patrice.vilchez@atmel.com>
> > Cc: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
> > Cc: Alan Cox <alan@linux.intel.com>
> > Cc: Greg Kroah-Hartman <gregkh@suse.de>
> 
> Ack for the serial side, its really an arch patch though as far as I
> can see..
applied in at91-l2

Best Regards,
J.
