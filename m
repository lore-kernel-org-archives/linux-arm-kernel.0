From: khilman@linaro.org (Kevin Hilman)
Date: Mon, 14 Oct 2013 15:19:38 -0700
Subject: [GIT PULL v2]socfpga: DTS updates for v3.13
In-Reply-To: <1381357034-14768-1-git-send-email-dinguyen@altera.com>
 (dinguyen@altera.com's message of "Wed, 9 Oct 2013 17:17:14 -0500")
References: <1381357034-14768-1-git-send-email-dinguyen@altera.com>
Message-ID: <87r4bn4hs5.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

<dinguyen@altera.com> writes:

> Hi Kevin, Olof, and Arnd:
>
> Please consider these DTS updates for the Altera SOCFPGA platform for v3.13:
>
> v2:
> Replace my Acked-by: with my Signed-off-by: for the patches from Steffen
> Trumtrar.

Thanks for the update.

> v1:
> Five of the six patches do NOT have an Ack from the DTS maintainers. I have
> sent the patches out for review, but since these patches do not change
> bindings nor add new ones, I don't think they will get too much attention.
>
> Thanks,
>
> Dinh
>
> The following changes since commit 4a10c2ac2f368583138b774ca41fac4207911983:
>
>   Linux 3.12-rc2 (2013-09-23 15:41:09 -0700)
>
> are available in the git repository at:
>
>   git://git.rocketboards.org/linux-socfpga-next.git tags/socfpga-dts-updates-for-v3.13
>
> for you to fetch changes up to 163a036468c2eb8f30658dff6c0de6c959f79b0d:
>
>   dts: socfpga: Add support for Altera's SOCFPGA Arria V board (2013-10-09 16:58:31 -0500)
>
> ----------------------------------------------------------------
> Updates to dts file structure for Altera's SOCFPGA
>
> * Does not include any new bindings or bindings change
> * Add dts file for a SOCFPGA with an Arria V FPGA
> * Add a clocks property for the TWD timer
> * Add support for Terasic SocKit Board which has Cyclone5 FPGA
> * From Steffen Trumtrar:
> "This series includes some minor cleanups (indentation and clock labels) and
> reorders the socfpga dts hierarchy from:
> 	socfpga.dtsi
> 	-> socfpga_$board.dts
> 	-> socfpga_$otherboard.dts
> to
> 	socfpga.dtsi
> 	-> socfpga_cyclone5.dtsi
> 	--> socfpga_cyclone5_$board.dts
> 	--> socfpga_cyclone5_$otherboard.dts
> "

Pulled into next/dt.

Kevin
