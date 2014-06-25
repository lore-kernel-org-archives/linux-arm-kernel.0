From: balbi@ti.com (Felipe Balbi)
Date: Tue, 24 Jun 2014 20:40:16 -0500
Subject: [PATCH v3 1/2] arm: dts: am4372: let boards access all nodes
 through phandles
In-Reply-To: <CAL_JsqJx_DJqxpEJebi0Etfv5g7=eYje_53vd_44GykreA-rkQ@mail.gmail.com>
References: <1403547659-24558-1-git-send-email-balbi@ti.com>
 <1403547659-24558-2-git-send-email-balbi@ti.com>
 <CAL_JsqJx_DJqxpEJebi0Etfv5g7=eYje_53vd_44GykreA-rkQ@mail.gmail.com>
Message-ID: <20140625014016.GA21616@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jun 24, 2014 at 04:11:48PM -0500, Rob Herring wrote:
> On Mon, Jun 23, 2014 at 1:20 PM, Felipe Balbi <balbi@ti.com> wrote:
> > by providing phandles to rtc, wdt, cpu and dispc nodes,
> > boards can access them to add board-specific data.
> 
> Strictly speaking, you are adding labels, not phandles. You can do

heh, fair point. Easily editable when applying, though (?)

> phandles without using labels, but the syntax is not so obvious. I'd
> tell you what it is but offhand I don't remember. :)

something along the lines of using the full path ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140624/1ea17a10/attachment.sig>
