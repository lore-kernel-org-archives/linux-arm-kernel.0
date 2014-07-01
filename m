From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 01 Jul 2014 09:06:31 +0200
Subject: [linux-sunxi] Re: [PATCH 7/9] ARM: dts: sun7i: Add new ba10-tvbox
 board
In-Reply-To: <CAGb2v66BO4W5Nrp-9X+20mK+7BObpdmc5x70BC5C7EGEHDcvew@mail.gmail.com>
References: <1404165479-23785-1-git-send-email-hdegoede@redhat.com>
 <1404165479-23785-8-git-send-email-hdegoede@redhat.com>
 <CAGb2v66BO4W5Nrp-9X+20mK+7BObpdmc5x70BC5C7EGEHDcvew@mail.gmail.com>
Message-ID: <53B25DF7.8050508@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 07/01/2014 04:16 AM, Chen-Yu Tsai wrote:
> On Tue, Jul 1, 2014 at 5:57 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>> The ba10 tvbox is an A10 based android tvbox, with 512M RAM, 8G nand flash,
>> rtl8188ctv usb wifi 1 USB-A receptacle hooked up to an EHCI/OHCI controller,
>> 1 USB-A receptacle hooked up to the OTG and 100Mbit ethernet using a
>> rtl8201 phy.
> 
> Nitpick on the subject, should be sun4i.

Right, I actually noticed that myself too, but I forgot to fix this up before
sending :|

Maxime, can you fix this up, or do you want a resend (and if resend, just this
patch or the entire set?).

Regards,

Hans
