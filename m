From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 13 Jul 2016 22:52:40 +0200
Subject: [PATCH] clk: sunxi: Add CSI (camera's Sensors Interface) module
 clock driver for sun[457]i
In-Reply-To: <CAJeuY78Mt-286pWvCVqPFnPixp3cQ+C=SHekCkMfAd7Lf_t1+w@mail.gmail.com>
References: <1458204222-31149-1-git-send-email-yassinjaffer@gmail.com>
 <1458204222-31149-2-git-send-email-yassinjaffer@gmail.com>
 <20160319235905.GA16539@rob-hp-laptop>
 <20160402011436.GA18567@codeaurora.org>
 <20160404212450.GP4227@lukather>
 <CAJeuY78Mt-286pWvCVqPFnPixp3cQ+C=SHekCkMfAd7Lf_t1+w@mail.gmail.com>
Message-ID: <20160713205240.GN4761@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jul 11, 2016 at 01:07:26AM +0800, Hao Zhang wrote:
> Hi all
> I am developing a media codec driver(using bt656) for cubieboard
> one(allwinner a10 processor), i want to use DT to banding csi. after i get
> some reference on
> Documentation/devicetree/bindings/media/video-interfaces.txt, i have some
> question about whether the csi driver for cubieboard one support to parse
> the DT node just like in the reference document? if not, whether someone
> is developing it or should i necessary to complete it together (What's the
> progress of it) ?

There's no driver for it yet. We're currently working on it, so it's
probably going to be done soon, but it's not there yet.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160713/6d4659d3/attachment.sig>
