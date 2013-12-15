From: david.lanzendoerfer@o2s.ch (David =?ISO-8859-1?Q?Lanzend=F6rfer?=)
Date: Sun, 15 Dec 2013 17:33:57 +0100
Subject: [PATCH 1/5] ARM: sunxi: Add driver for SD/MMC hosts found on
 Allwinner sunxi SoCs
In-Reply-To: <52ADBAA3.7060507@redhat.com>
References: <1387058295-20641-1-git-send-email-hdegoede@redhat.com>
 <20131215134415.GE3651@lukather> <52ADBAA3.7060507@redhat.com>
Message-ID: <1870422.7CyGeURSCU@dizzy-6.site>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi
> David, since you'll be doing v2 I guess you'll be filling in v2. FYI
> I've tested this on sun4i-a10, sun5i-a10s sun5i-a13 and sun7i-a20.
Yeah. I'll take care of it.
I'll work out a V2 which incorporates all the comments made on the first patch
set you've handed in.

> It uses dma in bus-master mode using a built-in designware idmac controller,
> which is identical to the one found in the mmc-dw hosts. Note the rest of
> the host is not identical, I've looked into reusing the mmc-dw driver but
> that does not seem like a good idea (manual sending stop commands
> versus auto stop on sunxi, completely different registers, etc.).
It's already a good thing, that I know now what the command set of the IDMAC 
controller is, since I had no idea how to configure it exactly.

> The plan is for David to send v2 of this patch-set so that should take care
> of that :)
ok
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131215/86b73642/attachment.sig>
