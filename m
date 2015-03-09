From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 9 Mar 2015 15:53:43 +0100
Subject: [PATCH 4/7] ARM: dts: sun5i: Add new Auxtek-t004 board
In-Reply-To: <54FC9FD2.6010309@redhat.com>
References: <1425754884-7875-1-git-send-email-hdegoede@redhat.com>
 <1425754884-7875-4-git-send-email-hdegoede@redhat.com>
 <20150308172157.GE5085@lukather> <54FC9FD2.6010309@redhat.com>
Message-ID: <20150309145343.GU5085@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 08, 2015 at 08:15:30PM +0100, Hans de Goede wrote:
> Hi,
> 
> On 08-03-15 18:21, Maxime Ripard wrote:
> >On Sat, Mar 07, 2015 at 08:01:21PM +0100, Hans de Goede wrote:
> >>The auxtek-t004:
> >>http://www.fasttech.com/products/1110/10004200/1318603-auxtek-t004-allwinner-a10s-single-core-android-ics
> >>
> >>Is an Allwinner A10s based hdmi tv stick with with 512M RAM, 4G nand flash,
> >>toc9002 (bcm43362) sdio wifi, 1 USB host ports using an USB-A receptacle and
> >>a 2 micro-usb receptacles, one for power and one for USB OTG.
> >>
> >>The sdio wifi appears to not have an oob irq hooked up, so we rely on sdio-irq
> >>support for it.
> >>
> >>Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> >>
> >>foo
> >
> >I'm not sure what that foo was about :)
> 
> Heh, that was the commit message of a fixup commit which I apparently
> added with a s (squash) rather then a f (fix) when doing a rebase -i leaving
> the foo in the combined commit msg. So now if you ever see a "foo" in a commit
> msg from me again you know where it comes from :)

Noted :)

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150309/e731aa6d/attachment.sig>
