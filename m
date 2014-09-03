From: geoff@infradead.org (Geoff Levand)
Date: Wed, 03 Sep 2014 11:30:46 -0700
Subject: [PATCH V3 0/6] ARM64: Add support for FSL's LS2085A SoC
In-Reply-To: <20140903155654.GK3127@leverpostej>
References: <1409757194-28155-1-git-send-email-bhupesh.sharma@freescale.com>
 <11626142.L1WDF72bmp@wuerfel>
 <d856a7c55a0949cd918411f3f834bbe3@BN1PR03MB220.namprd03.prod.outlook.com>
 <9081864.6l1AHRQ5bg@wuerfel> <20140903155654.GK3127@leverpostej>
Message-ID: <1409769046.21254.158.camel@smoke>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark.

On Wed, 2014-09-03 at 16:56 +0100, Mark Rutland wrote:
> Personally I'd like to see such things patched by the firmware/loader
> where possible (ideally with some way of switching said patching off if
> we really know better).

I think this makes sense for the enable method at least, since the
enable method is a service the firmware provides, and what the
firmware provides may vary over firmware revisions or even a single
revision configured differently.

-Geoff
