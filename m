From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 29 Mar 2016 12:07:56 +0200
Subject: [linux-sunxi] [PATCH v3 08/19] ARM: sun5i: Add DRAM gates
In-Reply-To: <CAGb2v66AV8FT7VLs-WV=QD-w-zYrOqgE--Gubq=+hnEUaqUH6g@mail.gmail.com>
References: <1458751122-23976-1-git-send-email-maxime.ripard@free-electrons.com>
 <1458751122-23976-9-git-send-email-maxime.ripard@free-electrons.com>
 <CAGb2v66AV8FT7VLs-WV=QD-w-zYrOqgE--Gubq=+hnEUaqUH6g@mail.gmail.com>
Message-ID: <20160329100755.GK30977@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 24, 2016 at 12:31:13PM +0800, Chen-Yu Tsai wrote:
> On Thu, Mar 24, 2016 at 12:38 AM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > The DRAM gates control whether the image / display devices on the SoC have
> > access to the DRAM clock or not.
> >
> > Enable it.
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> Acked-by: Chen-Yu Tsai <wens@csie.org>
> 
> I assume you'll add another version for A10s, or move the whole thing
> to sun5i.dtsi later?

Indeed.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160329/af9a1542/attachment.sig>
