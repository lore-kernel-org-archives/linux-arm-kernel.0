From: b32955@freescale.com (Huang Shijie)
Date: Wed, 11 Sep 2013 10:40:51 +0800
Subject: [PATCH v3 5/8] spi: Add Freescale QuadSpi driver
In-Reply-To: <20130910180923.GC29403@sirena.org.uk>
References: <1377828449-18912-1-git-send-email-b32955@freescale.com>
 <1377828449-18912-6-git-send-email-b32955@freescale.com>
 <20130910180923.GC29403@sirena.org.uk>
Message-ID: <522FD833.2060801@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2013?09?11? 02:09, Mark Brown ??:
> On Fri, Aug 30, 2013 at 10:07:26AM +0800, Huang Shijie wrote:
>> (0) What is the Quadspi controller?
>>
>>     The Quadspi(Quad Serial Peripheral Interface) acts as an interface to
>>     one single or two external serial flash devices, each with up to 4
>>     bidirectional data lines.
> For review and merge it would be much easier to send a patch which
> implements just the basic SPI support for this device then add the
> support for quad mode separately.
okay. I can remove the quad-read support in next version.

thanks
Huang Shijie
