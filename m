From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Fri, 30 Jan 2015 13:50:59 +0100
Subject: [PATCH] ARM: dts: mvebu: add ethernet to the cm-a510 board
In-Reply-To: <20150130133913.083d1ade@armhf>
References: <E1YH5bU-0005mG-3L@bombadil.infradead.org>
 <54CB5267.5060004@gmail.com> <20150130113118.5523ed68@armhf>
 <54CB6440.1010002@gmail.com> <20150130124144.501cf81d@armhf>
 <54CB732F.7010409@gmail.com> <20150130133913.083d1ade@armhf>
Message-ID: <54CB7E33.3080909@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30.01.2015 13:39, Jean-Francois Moine wrote:
> On Fri, 30 Jan 2015 13:03:59 +0100
> Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com> wrote:
>> Nope. The cm-a510 is just an add-on for a baseboard, it does not make
>> a working board. Just think of it as a feature-improved SoC.
>
> Well, I understand a bit, but I don't see clearly the physical system,
> nor how each part gets its configuration for booting.

TBH, I completely missed that the cm-a510 can come in different
configurations, e.g. with or without WiFi. Nevertheless, considering
that there are only a handful of configurations available, IMHO the
right thing would be a dtsi with all possible options described by
corresponding but disabled nodes.

The actual physical system has to be determined at runtime in any
way and it should be done by the bootloader. However, even the
bootloader would be happy to find the right nodes to enable instead
of creating them from scratch.

> As you know better than I, it seems that you are the right person to
> create the .dtsi/.dts's :) and to explain Gabriel how to use them!

Well, nothing that should stop you from improving your skills :)

I'd be happy to take over, but I admit that my current lack of spare
time would only allow me to support Gabriel and you.

Let's wait for Gabriel's response on how he can help improving
Dove mainline with his cm-a510 and baseboard.

Sebastian
