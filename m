From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 22 Feb 2016 17:53:41 -0300
Subject: [PATCH v1] ARM: dts: nitrogen6x: add USB host 1 support
In-Reply-To: <56CB7438.5030102@boundarydevices.com>
References: <1456171421-10044-1-git-send-email-ps.report@gmx.net>
 <56CB7438.5030102@boundarydevices.com>
Message-ID: <CAOMZO5BoPtUfL6PVzqLkZvwvn4=zNTTYgR1u4TOe4268cu+WLg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 22, 2016 at 5:48 PM, Troy Kisky
<troy.kisky@boundarydevices.com> wrote:

> I'm ok with this patch, but a more correct fix would be to add a
> reset-gpios to usbh1 instead, as this is a reset pin for
> a usb hub. So if nobody else has a problem,

The problem is that such solution does not exist today.

Peter Chen has been working on it lately.
