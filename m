From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 1 Jul 2014 10:16:44 +0800
Subject: [PATCH 7/9] ARM: dts: sun7i: Add new ba10-tvbox board
In-Reply-To: <1404165479-23785-8-git-send-email-hdegoede@redhat.com>
References: <1404165479-23785-1-git-send-email-hdegoede@redhat.com>
 <1404165479-23785-8-git-send-email-hdegoede@redhat.com>
Message-ID: <CAGb2v66BO4W5Nrp-9X+20mK+7BObpdmc5x70BC5C7EGEHDcvew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 1, 2014 at 5:57 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> The ba10 tvbox is an A10 based android tvbox, with 512M RAM, 8G nand flash,
> rtl8188ctv usb wifi 1 USB-A receptacle hooked up to an EHCI/OHCI controller,
> 1 USB-A receptacle hooked up to the OTG and 100Mbit ethernet using a
> rtl8201 phy.

Nitpick on the subject, should be sun4i.

> The PCB is labelled ba10 hence I've named the board ba10-tvbox. It is used
> in noname allwinner A10 tv-boxes.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
