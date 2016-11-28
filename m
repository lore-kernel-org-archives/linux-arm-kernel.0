From: uwe@kleine-koenig.org (=?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?=)
Date: Mon, 28 Nov 2016 11:54:11 +0100
Subject: [PATCH] ARM: dts: mvebu: Add Armada 38x labels and clean up
 Turris Omnia
In-Reply-To: <4ad1108a-43c4-46f8-4683-1c4b89996036@suse.de>
References: <1fc18002-0144-8300-1888-09f456860ef0@kleine-koenig.org>
 <1480272700-28888-1-git-send-email-afaerber@suse.de>
 <20161128103738.GT14217@n2100.armlinux.org.uk>
 <4ad1108a-43c4-46f8-4683-1c4b89996036@suse.de>
Message-ID: <e29e1a96-c9d5-d9b1-a42d-8afddc2714a7@kleine-koenig.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 11/28/2016 11:52 AM, Andreas F?rber wrote:
>> Please don't do this for clearfog - there's changes in the pipeline which
>> completely replace armada-388-clearfog.dts because there's a "base" and
>> "pro" versions of this hardware now, and making such a huge change will
>> effectively mean we have to start over with the DT files.
> 
> Would it help to split it back up into a series of add-labels,
> use-labels like I had originally? Then you could start using them in
> your refactoring as soon as the add-labels patch gets applied. Or are
> you completely against this style?

I'd even go as far as:

	1: add labels to .dtsi
	2: use labels on .dts#1
	3: use labels on .dts#2
	...

Best regards
Uwe


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161128/10666366/attachment.sig>
