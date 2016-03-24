From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 24 Mar 2016 11:40:37 +0100
Subject: [PATCH 3/4] arm64: dts: marvell: Clean up armada-7040-db
In-Reply-To: <87oaa4npbk.fsf@free-electrons.com>
References: <1458771861-12392-1-git-send-email-afaerber@suse.de>
 <1458771861-12392-4-git-send-email-afaerber@suse.de>
 <20160324091832.0060c907@free-electrons.com>
 <87oaa4npbk.fsf@free-electrons.com>
Message-ID: <20160324114037.1204b46e@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, 24 Mar 2016 11:27:27 +0100, Gregory CLEMENT wrote:

> > We haven't used this solution on Marvell Armada 32-bits SoCs, so there
> > needs to be a discussion on whether we want to go in this direction for
> > the 64 bits SoCs.
> 
> At first view using the label helps to have simpler dts files.
> 
> Is there any cons by using it?

The only minor drawback from my point of view is that you don't see
where in the hierarchy the device you're enabling is. But it's really a
minor drawback and not everybody agrees that it is actually a drawback.

So I'm fine.

> I agree that converting the Marvell Armada 32-bits SoCs would produce a
> lot of churn. But if some binding are common there is no file at all are
> in common, so we could use this solution for the 64 bits SoCs only.

Yes, we could. I'm fine with it. I was merely pointing out that it is
moving away from our 32 bits way of doing things.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
