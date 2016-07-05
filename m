From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 5 Jul 2016 08:54:31 +0200
Subject: [linux-sunxi] Re: [PATCH 1/4] ARM: dts: sun5i: Enable otg on the
 auxtex t004
In-Reply-To: <dbce3f4a-dbd6-2ee6-292a-6dec71b99d63@redhat.com>
References: <1467226022-10525-1-git-send-email-hdegoede@redhat.com>
 <20160629203838.GI6095@lukather>
 <dbce3f4a-dbd6-2ee6-292a-6dec71b99d63@redhat.com>
Message-ID: <20160705065431.GE7643@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 30, 2016 at 11:45:00AM +0200, Hans de Goede wrote:
> Hi,
> 
> On 29-06-16 22:38, Maxime Ripard wrote:
> >Hi,
> >
> >On Wed, Jun 29, 2016 at 08:46:59PM +0200, Hans de Goede wrote:
> >>The auxtek t004 has its otg usb vbus hardwired to 5v (likely in case
> >>people use it to power the board instead of the dedicated power micro
> >>usb connector), it does have an id pin, so it allows full otg
> >>functionality.
> >
> >I don't really get what you're saying here. Is the VBUS hardcoded to
> >5V, without any way to switch it, or it is not wired at all?
> 
> It is hardwired to 5v, quoting from my commit msg
> "has its otg usb vbus hardwired to 5v"
> 
> >In the former case, how can one of the PMIC output be related to the
> >board power input?
> 
> I believe it is not wired to the pmic output, but to the pmic 5v input.

Weird. Ok, I just applied it.

Thanks
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
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160705/47a7195d/attachment-0001.sig>
