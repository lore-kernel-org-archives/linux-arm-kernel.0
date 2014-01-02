From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 2 Jan 2014 19:10:22 +0100
Subject: [PATCH v2 3/7] tty: serial: Limit msm_serial_hs driver to
 platforms that use it
In-Reply-To: <1388438133-431-4-git-send-email-sboyd@codeaurora.org>
References: <1388438133-431-1-git-send-email-sboyd@codeaurora.org>
 <1388438133-431-4-git-send-email-sboyd@codeaurora.org>
Message-ID: <201401021910.22651.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 30 December 2013, Stephen Boyd wrote:
> The msm_serial_hs driver uses mach specific dma APIs. This is not
> compatible with the multi-platform ARM effort. Let's only compile
> this driver on MSM devices that are prepared to support it;
> allowing the DT based MSM devices to enter the multi-platform ARM
> build.
> 
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

Do you have a plan to deal with this in the future? Aren't you going
to need it in the future on modern SoCs?

	Arnd
