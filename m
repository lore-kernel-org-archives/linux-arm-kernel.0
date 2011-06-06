From: jic23@cam.ac.uk (Jonathan Cameron)
Date: Mon, 06 Jun 2011 16:08:58 +0100
Subject: RFC pcmcia soc_common/pcmcia_low_level: Making socket_init and
	socket_suspend optional
In-Reply-To: <4DECEC43.4090108@cam.ac.uk>
References: <4DECEC43.4090108@cam.ac.uk>
Message-ID: <4DECED8A.1000505@cam.ac.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry, sent this to the long dead old arm list.
> Hi All,
> 
> Whilst looking at tidying up some of the glue code in pcmcia/pxa2xx_*
> 
> I noticed a lot of boards (10) define empty versions of
> socket_init and socket_suspend.
> 
> This seems to me to indicate that these two functions should be optional.
> 
> Does anyone have any objection to making them so?
> 
> (couple of ifs in socket_common.c should do the job).
> 
> 
> Thanks,
> 
> Jonathan
