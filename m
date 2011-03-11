From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Fri, 11 Mar 2011 23:49:13 +0200
Subject: [PATCH v2 2/8] ARM: PXA: Z2: Enable OHCI on Zipit Z2
In-Reply-To: <201103112242.30235.marek.vasut@gmail.com>
References: <1299839023-16601-2-git-send-email-anarsoul@gmail.com>
	<1299855406-22652-1-git-send-email-anarsoul@gmail.com>
	<201103112242.30235.marek.vasut@gmail.com>
Message-ID: <201103112349.13252.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 11 March 2011 23:42:30 Marek Vasut wrote:
> On Friday 11 March 2011 15:56:46 Vasily Khoruzhick wrote:
> > This patch is a part of similar mozzwald's patch which was
> > based on GPSFan and rkdavis work.
> 
> Noone knows what/who is "mozzwald" or "rkdavis" or "GPSFan", the comment
> for this patch is irelevant and has zero information value.

Heh, I can add 'from Zipit Z2 community', I don't know their actual names nor 
mail addresses.
 
> I also suspect, the pins on the back connector are USB UDC, not UHC ...
> aka. the hardware has no UHC.

They are UHC, check http://www.mozzwald.com/node/60

Regards
Vasily
