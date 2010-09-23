From: christian@riesch.at (Christian Riesch)
Date: Thu, 23 Sep 2010 23:34:06 +0200
Subject: [PATCH v6 0/8] ptp: IEEE 1588 hardware clock support
In-Reply-To: <20100923223417.4ed62e5b@lxorguk.ukuu.org.uk>
References: <cover.1285261533.git.richard.cochran@omicron.at>	<alpine.DEB.2.00.1009231238170.2962@router.home>	<1285268380.2587.11.camel@localhost.localdomain>	<alpine.DEB.2.00.1009231402420.2962@router.home>	<1285273684.2587.92.camel@localhost.localdomain>	<alpine.DEB.2.00.1009231533040.7522@router.home>
	<20100923223417.4ed62e5b@lxorguk.ukuu.org.uk>
Message-ID: <4C9BC7CE.8020400@riesch.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alan Cox wrote:
>> It implies clock tuning in userspace for a potential sub microsecond
>> accurate clock. The clock accuracy will be limited by user space
>> latencies and noise. You wont be able to discipline the system clock
>> accurately.
> 
> Noise matters, latency doesn't. 

Well put! That's why we need hardware support for PTP timestamping to 
reduce the noise, but get along well with the clock servo that is 
steering the PHC in user space.

Christian
