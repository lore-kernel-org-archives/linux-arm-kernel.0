From: khilman@baylibre.com (Kevin Hilman)
Date: Fri, 07 Oct 2016 06:33:06 -0700
Subject: [RESEND PATCH v2 -next 0/3] ARM64: amlogic: Add support for GXL
 SoC Family
In-Reply-To: <1475595430-30075-1-git-send-email-narmstrong@baylibre.com> (Neil
 Armstrong's message of "Tue, 4 Oct 2016 17:37:07 +0200")
References: <1475595430-30075-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <7hfuo8ffn1.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> This is a resend rebased on linux-next-20161004 tag.
>
> The new Amlogic GXL SoCs (S905X and S905D) are part of the Meson GX family and
> share some common features that can be described in a common GX dtsi file used
> by the Meson GXBB and Meson GXL Family dtsi.
>
> This patchset introduces the common GX dtsi and switches the GXBB to use
> the common GX dtsi.
> Then it introduces the GXL S905X SoC with the GXL common dtsi, then the S905D
> dtsi and the p212 board dts.
> Finally the GXL S905D SoC is introduced with a S905D dtsi using the GXL common
> and the p23x Board dtsi for the p231 and p230 development boards.
>
> Changes since v1 at http://lkml.kernel.org/r/20160903082227.30559-1-narmstrong at baylibre.com :
>  - Add missing copyrigh in gx dtsi
>  - Rename gxl SoCs compatibles to amlogic,s905x and amlogic,s905d
>
> Changes since RFC v1:
>  - Merge GX common and GXBB changes in a single patch
>  - Integrate GXL S905X patch
>  - Add support for S905D and the p23x boards
>
> Note: This patchset integrates the patch "ARM64: dts: amlogic: Add basic support for Amlogic S905X" [1]
> from Carlo Caione.

I'm applying this series as the first DT change for v4.10, so all future
DT patches should be applied on top of this.

It's available in the v4.10/dt64 branch of my tree[1].

Kevin

[1] https://git.kernel.org/cgit/linux/kernel/git/khilman/linux-amlogic.git
