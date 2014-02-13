From: tony@atomide.com (Tony Lindgren)
Date: Thu, 13 Feb 2014 14:46:14 -0800
Subject: [PATCH 0/2] ARM: DTS: am335x-evmsk: Audio and MMC1 fix (for 3.13?)
In-Reply-To: <52CBB788.9070404@ti.com>
References: <1387790915-7217-1-git-send-email-peter.ujfalusi@ti.com>
 <52CBB788.9070404@ti.com>
Message-ID: <20140213224613.GC28216@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [140107 00:16]:
> Hi Benoit,
> 
> On 12/23/2013 11:28 AM, Peter Ujfalusi wrote:
> > Hi,
> > 
> > The audio frequency has been incorrectly set in the DTS file which results
> > incorrect playback frequency on EVM-SK.
> > 
> > The SD card can not be used without the second patch on 3.13-rc5.
> 
> Can you take a look at these and if it is possible send it for 3.13?

Applying both into omap-for-v3.14/fixes thanks.

Tony
