From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Wed, 11 Jan 2017 09:06:30 +0100
Subject: [PATCH v3 0/4] TI DA8xx/OMAPL13x/AM17xx/AM18xx/66AK2x UART
In-Reply-To: <1483642460-6891-1-git-send-email-david@lechnology.com>
References: <1483642460-6891-1-git-send-email-david@lechnology.com>
Message-ID: <20170111080630.GA28580@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 05, 2017 at 12:54:16PM -0600, David Lechner wrote:
> This series adds a new UART port type for TI DA8xx/OMAPL13x/AM17xx/AM18xx/66AK2x
> UART. These SoCs have a non-standard register for UART power management that
> needs special handling in the UART driver.
> 
> Greg, the first two patches will need to go through your tree. Sekhar and
> Santosh will pick up the 3 and 4 patches respectively.

Ok, I've now taken those two.

thanks,

greg k-h
