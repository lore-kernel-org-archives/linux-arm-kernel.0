From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 13 Jan 2012 14:13:44 -0800
Subject: [PATCH 06/11] ep93xx: Don't use system controller defines in
 audio drivers
In-Reply-To: <4F10A4F7.60503@gmail.com>
References: <1326251676-7593-1-git-send-email-rmallon@gmail.com>
 <1326251676-7593-7-git-send-email-rmallon@gmail.com>
 <ADE657CA350FB648AAC2C43247A983F001F3F99EBB04@AUSP01VMBX24.collaborationhost.net>
 <4F10A4F7.60503@gmail.com>
Message-ID: <20120113221343.GB1013@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 14, 2012 at 08:41:11AM +1100, Ryan Mallon wrote:
> On 14/01/12 04:35, H Hartley Sweeten wrote:

> > Maybe the ep93xx_i2s_acquire() function should be renamed to something
> > like ep93xx_i2s_ac97_acquire() so that the i2s configuration is understood.
> > This should address Mark Brown's issue.

> Mark has already picked this patch up. I can probably modify it and get
> him to grab the new one, but the reason I didn't change the name is
> because there have been only two users of this function for a couple of
> years now, and the ep93xx is obsolete, so its unlikely that we are going
> to need a new function anyway.

If you do change it then please send an incremental patch rather than a
new version.  I'm OK whatever you guys decide here.
