From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 27 Jan 2014 15:57:14 +0100
Subject: [PATCH] sunxi: dts: add a note that memory size is adjusted by
 boot loader.
In-Reply-To: <52E399F4.1040300@redhat.com>
References: <1390572852-15027-1-git-send-email-ijc@hellion.org.uk>
 <52E2874F.10703@redhat.com>
 <1390578114.13513.13.camel@kazak.uk.xensource.com>
 <52E399F4.1040300@redhat.com>
Message-ID: <20140127145714.GL3867@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ian, Hans,

On Sat, Jan 25, 2014 at 12:03:16PM +0100, Hans de Goede wrote:
> Hmm, I've no idea what the default / preferred way of handling this is,
> I assume Maxime knows, so lets wait for his input on this.

I got the habit of setting the memory node to the max size the RAM
controller can handle from previous work on imx, but I don't really
have a preferrence here.

If that confuses people, we can just remove it from the DTSI
altogether. It will be patched by u-boot anyway, and we won't have to
create DTS variants this way.

Just don't do it for the A31 for the moment, since we don't have
DT-enabled u-boot for now.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140127/e91902ab/attachment.sig>
