From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 8 Mar 2015 18:26:38 +0100
Subject: [linux-sunxi] [PATCH 7/7] ARM: dts: sun7i: Enable cap-sdio-irq
 for bananapro sdio wifi
In-Reply-To: <54FC3239.5030200@redhat.com>
References: <1425754884-7875-1-git-send-email-hdegoede@redhat.com>
 <1425754884-7875-7-git-send-email-hdegoede@redhat.com>
 <CAGb2v65tcCrg3njNN0owLrM-MUepRBwjxpU46dpXkLhy9mceEA@mail.gmail.com>
 <54FC3239.5030200@redhat.com>
Message-ID: <20150308172638.GH5085@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 08, 2015 at 12:27:53PM +0100, Hans de Goede wrote:
> Hi,
> 
> On 08-03-15 03:42, Chen-Yu Tsai wrote:
> >On Sun, Mar 8, 2015 at 3:01 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> >>The sdio wifi on the Banana Pro does not appear to have an oob irq hooked
> >>up, so enable sdio-irq support to avoid unnecessary polling.
> >
> >I wonder if this is stable enough to put back into the mmc driver, i.e.
> >declare the capability in the driver itself? IIRC at one point it did.
> 
> That is a good question, I believe strongly that the sdio wifi issues we've
> been seeing which were the reason to disable cap-sdio-irq in the driver are
> actually unrelated to the irq delivery mechanism. So IMHO yes we can just enable
> this for all devices in the driver, and yes that would be a better solution.
> 
> Maxime, if I send a patch to enable cal-sdio-irq at the driver level ( as it
> really is a hardware feature not a board feature), will you ack it ?

You know a lot more than I do on this, so I fully trust you. If you
feel like it's the best solution, go ahead.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150308/a70e052d/attachment-0001.sig>
