From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 31 Jul 2016 17:24:48 +0200
Subject: [PATCH 2/3] phy: sun4i: add support for A64 usb phy
In-Reply-To: <CAGb2v65tbM=-4HthAiN2hLvKYCSQg_WDCXrFcAO94cohd1FfDA@mail.gmail.com>
References: <20160731112536.4625-1-icenowy@aosc.xyz>
 <20160731112536.4625-2-icenowy@aosc.xyz>
 <706a0517-a2bf-ee67-338d-859f67105cee@redhat.com>
 <CAGb2v65tbM=-4HthAiN2hLvKYCSQg_WDCXrFcAO94cohd1FfDA@mail.gmail.com>
Message-ID: <3c258405-fab0-a1b1-478f-2f61121012fc@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 31-07-16 16:50, Chen-Yu Tsai wrote:

> FYI: H3 USB PHY support is not complete. USB0 PHY is not supported, and
> it does not work. I did a preliminary comparison of this PHY driver and
> the code in Allwinner's SDK. There are some bits missing.

Right that is a known issue, I believe someone was working on an
otg support patch series for the H3 though ?

Regards,

Hans
