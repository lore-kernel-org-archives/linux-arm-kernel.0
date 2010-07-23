From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 23 Jul 2010 10:15:04 +0100
Subject: [PATCH v2 10/20] omap: zoom: add fixed regulator device for wlan
In-Reply-To: <AANLkTin2dyLNo1RMQgLG-4DtN-CsXqNNLAfITXDbMIvl@mail.gmail.com>
References: <1279733634-21974-1-git-send-email-ohad@wizery.com>
	<1279733634-21974-11-git-send-email-ohad@wizery.com>
	<20100721175930.GD10930@sirena.org.uk> <4C48287D.1000603@nokia.com>
	<AANLkTin2dyLNo1RMQgLG-4DtN-CsXqNNLAfITXDbMIvl@mail.gmail.com>
Message-ID: <20100723091503.GA12300@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 23, 2010 at 02:13:38AM +0300, Ohad Ben-Cohen wrote:
> On Thu, Jul 22, 2010 at 2:16 PM, Roger Quadros <roger.quadros@nokia.com> wrote:
> > .dev_name ? ? ? = "mmci-omap-hs.2"

> I already set the .dev member of the consumer in a similar manner to
> how all other regulators are configured in this board - please check
> out patch 13:

> https://patchwork.kernel.org/patch/113418/

> Does this look reasonable to you ?

You should really be using dev_name in preference to dev these days
unless there's a *very* good reason.
