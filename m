From: alan@linux.intel.com (Alan Cox)
Date: Wed, 13 Apr 2011 22:58:18 +0100
Subject: [PATCH] atmel_serial: keep the platform_device unchanged
In-Reply-To: <1302724038-26236-1-git-send-email-plagnioj@jcrosoft.com>
References: <1302724038-26236-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <20110413225818.39ce5104@bob.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 13 Apr 2011 21:47:18 +0200
Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com> wrote:

> specify the port num via platform_data this will allow to match the
> clock with the plaform_dev staticly
> 
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD
> <plagnioj@jcrosoft.com> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: Patrice Vilchez <patrice.vilchez@atmel.com>
> Cc: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
> Cc: Alan Cox <alan@linux.intel.com>
> Cc: Greg Kroah-Hartman <gregkh@suse.de>

Ack for the serial side, its really an arch patch though as far as I
can see..
