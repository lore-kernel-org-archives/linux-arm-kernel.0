From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Mon, 28 Nov 2016 11:52:26 +0100
Subject: [PATCH] ARM: dts: mvebu: Add Armada 38x labels and clean up
 Turris Omnia
In-Reply-To: <20161128103738.GT14217@n2100.armlinux.org.uk>
References: <1fc18002-0144-8300-1888-09f456860ef0@kleine-koenig.org>
 <1480272700-28888-1-git-send-email-afaerber@suse.de>
 <20161128103738.GT14217@n2100.armlinux.org.uk>
Message-ID: <4ad1108a-43c4-46f8-4683-1c4b89996036@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Am 28.11.2016 um 11:37 schrieb Russell King - ARM Linux:
> On Sun, Nov 27, 2016 at 07:51:39PM +0100, Andreas F?rber wrote:
>> To more consistently reference nodes by label, add labels for sata,
>> usb2, sdhci and usb3 nodes.
>>
>> Convert all other 38x boards for consistency. Add labels for nfc and rtc.
> 
> Please don't do this for clearfog - there's changes in the pipeline which
> completely replace armada-388-clearfog.dts because there's a "base" and
> "pro" versions of this hardware now, and making such a huge change will
> effectively mean we have to start over with the DT files.

Would it help to split it back up into a series of add-labels,
use-labels like I had originally? Then you could start using them in
your refactoring as soon as the add-labels patch gets applied. Or are
you completely against this style?

Thanks for pointing this out,

Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
