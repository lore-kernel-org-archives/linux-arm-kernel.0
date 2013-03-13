From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 13 Mar 2013 10:23:00 +0000
Subject: [PATCH] ASoC: samsung: remove last traces of neo1973-gta01
In-Reply-To: <1363126175.3137.160.camel@x61.thuisdomein>
References: <1363126175.3137.160.camel@x61.thuisdomein>
Message-ID: <20130313102300.GC25610@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 12, 2013 at 11:09:35PM +0100, Paul Bolle wrote:
> The (rudimentary) support for the Openmoko Neo1973 GTA01 got removed in
> commit 1ae5cbc52e7c6619a3f44b87809fd25370df31bb ("ASoC: neo1973_wm8753:
> remove references to the neo1973-gta01 machine"). Remove its last traces
> in the Kconfig file too.

The support wasn't rudimentary, it was a pretty much complete audio
driver.  Anyway I've applied this with a fixed up commit message.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130313/5ec2d461/attachment.sig>
