From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Thu, 13 May 2010 13:44:02 +0300
Subject: approaching last call for updatyes
In-Reply-To: <AANLkTimHifdCStUZJ_Xgyf2n5mA47Jdj2zscWNB13LDq@mail.gmail.com>
References: <20100513091540.GK26401@trinity.fluff.org>
	<AANLkTimHifdCStUZJ_Xgyf2n5mA47Jdj2zscWNB13LDq@mail.gmail.com>
Message-ID: <201005131344.13949.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? ????????? ?? 13 ??? 2010 12:37:30 ????? christian pellegrin ???????:
> The fix for NAND clock stop on idle is missing. Without it I suggest
> to mark the option CONFIG_MTD_NAND_S3C2410_CLKSTOP broken.

Confirmed, CLKSTOP option is not working on my rx1950, I'm not able to
read NAND after resume from suspend with CLKSTOP enabled.

Regards
Vasily
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100513/50f91ff0/attachment.sig>
