From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Thu, 8 May 2014 12:39:12 +0300
Subject: [PATCH v2 2/3] ARM: dts: oma3-gta04: Add display support
In-Reply-To: <CAAfyv36L_vh+iwrqsePsF8oOxOJ=JXUAk2nJ6F120w+0ivAn8w@mail.gmail.com>
References: <1398284120-4986-1-git-send-email-marek@goldelico.com>	<1398284120-4986-3-git-send-email-marek@goldelico.com>	<5369DAC6.6050608@ti.com>
 <CAAfyv36L_vh+iwrqsePsF8oOxOJ=JXUAk2nJ6F120w+0ivAn8w@mail.gmail.com>
Message-ID: <536B50C0.7030002@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/05/14 10:21, Belisko Marek wrote:

>> Did you try this on 3.15-rc? The above is not right, and I don't think
>> it works. You need 'port' node for the dpi_out endpoint.
> This patches was tested against 3.15 series and it works. I'l recheck.

Ah, we still have some code that makes that work. But it's against the
bindings documentations, and that code will be removed. So better add
the port node.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140508/6772b777/attachment.sig>
