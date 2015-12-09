From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 9 Dec 2015 10:20:32 +0100
Subject: [linux-sunxi][PATCH 0/2] ARM: dts: sun4i: mk802 variant patches
In-Reply-To: <1449600534-5098-1-git-send-email-codekipper@gmail.com>
References: <1449600534-5098-1-git-send-email-codekipper@gmail.com>
Message-ID: <20151209092032.GX27957@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Dec 08, 2015 at 07:48:52PM +0100, codekipper at gmail.com wrote:
> From: Marcus Cooper <codekipper@gmail.com>
> 
> This patch series splits the mk802 dts into common include file which
> can be shared with the mk802+ device. The only difference that I can
> see between this and the original device is that it has an internal
> microphone.

Internal microphone that is not represented in the DT :)

> With that in mind we can either leave things as they are and enable
> the capture to the original mk802 dts or apply this patch to distinguish
> between the two devices.

Since there's exactly no difference between the two DTs, is there a
point at merging these patches?

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151209/a5d839cf/attachment.sig>
