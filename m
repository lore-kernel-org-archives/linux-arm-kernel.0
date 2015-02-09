From: HenryC.Chen@mediatek.com (=?big5?B?SGVucnlDIENoZW4gKLOvq9i7qCk=?=)
Date: Mon, 9 Feb 2015 03:05:41 +0000
Subject: [PATCH v4 0/7] clk: Add common clock support for Mediatek
 MT8135 and MT8173.
In-Reply-To: <20150206151542.GO12209@pengutronix.de>
References: <1422594798-13375-1-git-send-email-henryc.chen@mediatek.com>
 <CABuKBeJSH3WzG3QC=9OoPzXE6fd9W2U67V4c19NzWcPxWR7VDg@mail.gmail.com>
 <20150206103033.GS18908@pengutronix.de>
 <CABuKBeJBp115aD_xb7_2471h=iyr5Wc33m2EX715MxNc=_1p2A@mail.gmail.com>
 <20150206151542.GO12209@pengutronix.de>
Message-ID: <973C649EAEADCC47B3D0BEB0BD37EB2F0495E9A3@mtkmbs08n1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

It's okay for me, thanks.

Henry

> -----Original Message-----
> From: Sascha Hauer [mailto:s.hauer at pengutronix.de]
> Sent: Friday, February 06, 2015 11:16 PM
> To: Matthias Brugger
> Cc: HenryC Chen (???); Rob Herring; Mike Turquette; srv_heupstream;
> Sascha Hauer; JamesJJ Liao (???); Eddie Huang (???); Pawel Moll;
> Mark Rutland; Ian Campbell; Kumar Gala; Russell King; Catalin Marinas;
> Vladimir Murzin; Ashwin Chaugule; Yingjoe Chen (???);
> devicetree at vger.kernel.org; linux-kernel at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; linux-mediatek at lists.infradead.org
> Subject: Re: [PATCH v4 0/7] clk: Add common clock support for Mediatek
> MT8135 and MT8173.
> 
> On Fri, Feb 06, 2015 at 03:20:35PM +0100, Matthias Brugger wrote:
> > > I don't really understand the "as part of the clk driver part". I
> > > now have replaced the devm_regmap_init_mmio with
> > > syscon_node_to_regmap in the pericfg / infracfg drivers. Is that
> all
> > > that you want or do you want me to move the source code to
> drivers/clk/mediatek?
> >
> > Yes, I propose to move the source code to drivers/clk/mediatek.
> > Please have a look on other clock drivers which implement the reset
> > controller, e.g. rockchip.
> 
> Ok, I'm halfway through implementing this, but let's have weekend first.
> 
> Henry, If you're fine with this I'll change your clock series according
> to Matthias suggestions.
> 
> Sascha
> 
> --
> Pengutronix e.K.                           |
> |
> Industrial Linux Solutions                 | http://www.pengutronix.de/
> |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0
> |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-
> 5555 |

************* Email Confidentiality Notice ********************
The information contained in this e-mail message (including any 
attachments) may be confidential, proprietary, privileged, or otherwise
exempt from disclosure under applicable laws. It is intended to be 
conveyed only to the designated recipient(s). Any use, dissemination, 
distribution, printing, retaining or copying of this e-mail (including its 
attachments) by unintended recipient(s) is strictly prohibited and may 
be unlawful. If you are not an intended recipient of this e-mail, or believe 
that you have received this e-mail in error, please notify the sender 
immediately (by replying to this e-mail), delete any and all copies of 
this e-mail (including any attachments) from your system, and do not
disclose the content of this e-mail to any other person. Thank you!
