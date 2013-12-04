From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Wed, 4 Dec 2013 11:54:12 -0800
Subject: [PATCH 2/5] tty: serial: Limit msm_serial_hs driver to platforms
 that use it
In-Reply-To: <1386185952-27259-3-git-send-email-sboyd@codeaurora.org>
References: <1386185952-27259-1-git-send-email-sboyd@codeaurora.org>
 <1386185952-27259-3-git-send-email-sboyd@codeaurora.org>
Message-ID: <20131204195412.GA28909@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 04, 2013 at 11:39:09AM -0800, Stephen Boyd wrote:
> The msm_serial_hs driver uses mach specific dma APIs. This is not
> compatible with the multi-platform ARM effort. Let's only compile
> this driver on MSM devices that are prepared to support it;
> allowing the DT based MSM devices to enter the multi-platform ARM
> build.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
