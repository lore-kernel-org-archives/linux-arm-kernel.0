From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 27 Jan 2016 16:46:49 +0100
Subject: [linux-sunxi][PATCH v4 0/3] ARM: dt: sunxi: Add Itead Ibox support
In-Reply-To: <1453562299-18495-1-git-send-email-codekipper@gmail.com>
References: <1453562299-18495-1-git-send-email-codekipper@gmail.com>
Message-ID: <20160127154649.GE4317@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 23, 2016 at 04:18:16PM +0100, codekipper at gmail.com wrote:
> From: Marcus Cooper <codekipper@gmail.com>
> 
> Hi All,
> 
> this patch series is an extension of the initial patch delivery for the
> Itead Ibox as found here
> https://groups.google.com/d/msg/linux-sunxi/GR_co3ObW8s/0BTPQljmAAAJ.
> 
> There seems to be a few Itead variants out there based on their A10/A20
> core module and this patch series attempts to organise the device tree
> files with some consideration that these variants may be added later.
> 
> I've also converted the A10 Itead Iteaduino dts to use this common file.
> As I don't have this board to verify the changes I simply compared the
> output of the fdtdump before and after applying these patches. The only
> difference was the reduction to the dcdc2 max voltage.
> 

Applied all three, thanks!

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160127/65a374a4/attachment.sig>
