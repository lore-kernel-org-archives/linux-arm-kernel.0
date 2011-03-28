From: john.stultz@linaro.org (John Stultz)
Date: Mon, 28 Mar 2011 11:06:35 -0700
Subject: [PATCH V13 1/4] ptp: Added a brand new class driver for ptp
	clocks.
In-Reply-To: <86641738e4c84fbdb105d6f2eb6141d5d13c3190.1301206090.git.richard.cochran@omicron.at>
References: <cover.1301206090.git.richard.cochran@omicron.at>
	<86641738e4c84fbdb105d6f2eb6141d5d13c3190.1301206090.git.richard.cochran@omicron.at>
Message-ID: <1301335595.21829.0.camel@work-vm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2011-03-27 at 08:38 +0200, Richard Cochran wrote:
> This patch adds an infrastructure for hardware clocks that implement
> IEEE 1588, the Precision Time Protocol (PTP). A class driver offers a
> registration method to particular hardware clock drivers. Each clock is
> presented as a standard POSIX clock.
> 
> The ancillary clock features are exposed in two different ways, via
> the sysfs and by a character device.
> 
> Signed-off-by: Richard Cochran <richard.cochran@omicron.at>

Acked-by: John Stultz <john.stultz@linaro.org>

thanks
-john
