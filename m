From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Thu, 8 Apr 2010 15:23:02 +0800
Subject: devicetree in arm
In-Reply-To: <4BBD7A9A.9090501@canonical.com>
References: <dac45061003180504k49a9f303y4329530a5b475108@mail.gmail.com>
	<k2tfa686aa41004072331p7541292ajc35521cf24fd24c6@mail.gmail.com>
	<4BBD7A9A.9090501@canonical.com>
Message-ID: <201004081523.04607.jeremy.kerr@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bryan,

> I'm very happy to try that on my real Freescale i.MX51 board. Any hints
> about that?

Support for imx51 is a work-in-progress. As Grant has said, I have some 
patches (in my mx51 branch), but they're mostly experimental at the moment.

I'm in the middle of reviewing & merging some new patches from Rob Herring, 
which add DT support to imx51 - I'll update the wiki page when we have things 
working on hardware :)

Cheers,


Jeremy
