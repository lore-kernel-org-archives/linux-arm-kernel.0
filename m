From: olof@lixom.net (Olof Johansson)
Date: Wed, 19 Apr 2017 05:47:15 -0700
Subject: [GIT PULL] Allwinner H3 DT changes for 4.12
In-Reply-To: <20170406093106.hcjthwt5vemw4xnw@lukather>
References: <20170406093106.hcjthwt5vemw4xnw@lukather>
Message-ID: <20170419124715.GU17004@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 06, 2017 at 11:31:06AM +0200, Maxime Ripard wrote:
> Hi Arnd, Olof,
> 
> Here is a serie of patches a bit unusual for the next merge window.
> 
> Allwinner released a new SoC, the H5, that is basically an H3 with
> arm64 CPU cores (A53 instead of A7).
> 
> In order to support it properly, we've created a common DTSI, and
> built on top. Since that DTSI is spread across arm and arm64, it took
> a bit of rework (all the patches in that PR until commit da89e1d5cbaf
> ("ARM: sunxi: h3/h5: add usb_otg and OHCI/EHCI for usbc0 on H3/H5"))
> that is shared with the next PR I'm about to send with the H5-only patches.
> 
> The patches on top of that commit are H3-specific commits and should
> be merged through your arm DT branch.
> 
> Let me know if you have any questions,
> Maxime
> 
> The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:
> 
>   Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)
> 
> are available in the git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunxi-dt-h3-for-4.12
> 
> for you to fetch changes up to 72897fa31fcf6222a11c6ebb0bcca25628bb1f7c:
> 
>   ARM: sun8i: h2+: enable USB OTG for Orange Pi Zero board (2017-03-27 13:45:32 +0200)
> 
> ----------------------------------------------------------------
> Allwinner H3 DT changes for 4.12
> 
> H3 patches for 4.12, which are mostly related to reworking the H3 DTSI to
> be usable on the arm64 H5 DTSI, that shares almost everything with the H3
> but the CPU cores.
> 
> We also have some new device addition (USB, mostly) that would conflict
> otherwise.

Merged into next/dt. Thanks.


-Olof
