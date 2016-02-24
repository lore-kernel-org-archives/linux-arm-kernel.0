From: peter.chen@nxp.com (Peter Chen)
Date: Wed, 24 Feb 2016 09:33:59 +0000
Subject: [PATCH v1] ARM: dts: nitrogen6x: add USB host 1 support
In-Reply-To: <CAOMZO5BoPtUfL6PVzqLkZvwvn4=zNTTYgR1u4TOe4268cu+WLg@mail.gmail.com>
References: <1456171421-10044-1-git-send-email-ps.report@gmx.net>
 <56CB7438.5030102@boundarydevices.com>
 <CAOMZO5BoPtUfL6PVzqLkZvwvn4=zNTTYgR1u4TOe4268cu+WLg@mail.gmail.com>
Message-ID: <HE1PR04MB14503F844CF2C8E898DB03DE8BA50@HE1PR04MB1450.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 
> 
> On Mon, Feb 22, 2016 at 5:48 PM, Troy Kisky
> <troy.kisky@boundarydevices.com> wrote:
> 
> > I'm ok with this patch, but a more correct fix would be to add a
> > reset-gpios to usbh1 instead, as this is a reset pin for a usb hub. So
> > if nobody else has a problem,
> 
> The problem is that such solution does not exist today.
> 
> Peter Chen has been working on it lately.

Yes, I will cc you when I send new patch.

Peter
