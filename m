From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 28 Apr 2015 13:27:18 +0200
Subject: [PATCH 0/6] ARM: berlin: relicense the device trees under
 GPLv2/X11
In-Reply-To: <1430057013-12842-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1430057013-12842-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <553F6E96.10001@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26.04.2015 16:03, Antoine Tenart wrote:
> Hi,
>
> The GPLv2 license makes it impractical for other software components
> licensed under another license to use our device trees. To fix this,
> and make our device tree usable by other software components, relicense
> them under a GPLv2/X11 dual-license.
>
> In order to get this accepted, we *need* all contributors to the Berlin
> device tree files to ack-by the patches applying on a file they
> contributed on. A list of needed ack-by by device tree is shown below:
>
>   * berlin2q.dtsi:
>          Antoine Tenart <antoine.tenart@free-electrons.com>
>          Jisheng Zhang <jszhang@marvell.com>
> 	Alexandre Belloni <alexandre.belloni@free-electrons.com>
>          Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
>
>   * berlin2q-marvell-dmp.dtsi:
>          Antoine Tenart <antoine.tenart@free-electrons.com>
>          Jisheng Zhang <jszhang@marvell.com>
>
>   * berlin2.dtsi:
>          Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
>          Antoine Tenart <antoine.tenart@free-electrons.com>
>          Jisheng Zhang <jszhang@marvell.com>
>
>   * berlin2-sony-nsz-gs7.dts:
>          Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
>
>   * berlin2cd.dtsi:
>          Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
>          Antoine Tenart <antoine.tenart@free-electrons.com>
>          Jisheng Zhang <jszhang@marvell.com>
>
>   * berlin2cd-google-chromecast.dts:
>          Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

Applied to berlin/dt with the corresponding Acked-by's.

Thanks!

Sebastian
