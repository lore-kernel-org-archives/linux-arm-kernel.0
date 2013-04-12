From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 12 Apr 2013 12:26:18 +0100
Subject: [alsa-devel] [PATCH 18/30] ASoC: samsung: move plat/ headers to
 local directory
In-Reply-To: <5167EA36.5080505@metafoo.de>
References: <1365638712-1028578-1-git-send-email-arnd@arndb.de>
 <1365638712-1028578-19-git-send-email-arnd@arndb.de>
 <20130411164751.GK9243@opensource.wolfsonmicro.com>
 <201304111908.42532.arnd@arndb.de>
 <20130411171938.GS9243@opensource.wolfsonmicro.com>
 <5167EA36.5080505@metafoo.de>
Message-ID: <20130412112618.GW9243@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 12, 2013 at 01:04:22PM +0200, Lars-Peter Clausen wrote:
> On 04/11/2013 07:19 PM, Mark Brown wrote:

> > Hrm, someone killed GTA02 support?  That's sad...  if that's really the
> > case we could kill the machine driver but not tonight as I'm running
> > late...

> I think the file was moved, we should pull over the audio relevant GPIO
> definitions into the ASoC board driver.

Yeah, so I see - Heiko sent a patch fixing this.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130412/1aa1c9e9/attachment.sig>
