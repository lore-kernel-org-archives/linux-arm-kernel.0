From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 07 May 2015 15:01:05 +0200
Subject: [PATCH v3 0/2] reset driver for NXP LPC18xx family
In-Reply-To: <1430863827-21898-1-git-send-email-manabian@gmail.com>
References: <1430863827-21898-1-git-send-email-manabian@gmail.com>
Message-ID: <1431003665.3014.36.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, den 06.05.2015, 00:10 +0200 schrieb Joachim Eastwood:
> This patch set adds a reset driver for NXP LPC18xx/43xx devices.
> 
> Changes in v3:
> * add patch descriptions
> * change parameter name in to_rgu_data macro to avoid a potential
>   issue if code is changed.
> 
> Changes in v2:
> * clean up header includes
> * prefix M0 reset defines with LPC43XX
> * fix comment about M0 reset lines
> * reorganize reset call chains
> * add reset number table to dt doc
> 
> There are no dependencies in this patch set. The DTS changes will
> be sent separately to arm-soc once this patch set goes upstream.
> 
> Base support for the NXP LPC18xx family can be found here:
> http://marc.info/?l=linux-arm-kernel&m=143016894704253&w=2
> 
> Joachim Eastwood (2):
>   reset: add driver for lpc18xx rgu
>   doc: dt: add documentation for lpc1850-rgu reset driver

Applied both, thanks.

regards
Philipp
