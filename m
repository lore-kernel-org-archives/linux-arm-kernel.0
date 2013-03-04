From: balbi@ti.com (Felipe Balbi)
Date: Mon, 4 Mar 2013 13:13:04 +0200
Subject: [PATCH v10 6/8] usb: chipidea: imx: add internal vbus regulator
 control
In-Reply-To: <CAEYLNCpNfNtpmGL-POaJ=3HJpnPnK9+vJvJ_g8_jZcmqqy=XRA@mail.gmail.com>
References: <1361946799-29471-1-git-send-email-peter.chen@freescale.com>
 <1361946799-29471-7-git-send-email-peter.chen@freescale.com>
 <20130227075510.GB8016@arwen.pp.htv.fi>
 <20130227080735.GH1906@pengutronix.de>
 <20130227081313.GI20402@nchen-desktop>
 <20130227083610.GK8016@arwen.pp.htv.fi>
 <CAEYLNCpNfNtpmGL-POaJ=3HJpnPnK9+vJvJ_g8_jZcmqqy=XRA@mail.gmail.com>
Message-ID: <20130304111304.GB3397@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

On Wed, Feb 27, 2013 at 04:43:22PM +0200, Darius Augulis wrote:
> Hi balbi,
> 
> actually no. I don't work with this hardware any more and don't have
> free time to support it.
> Please feel free to remove it if it breaks other things.

since nobody seems to care about imx_udc and it's currently even
including unexistent headers, I'll schedule it for removal on v3.11
(skipping v3.10 to give time for people to complain). Is that alright
with you ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130304/6fff7238/attachment.sig>
