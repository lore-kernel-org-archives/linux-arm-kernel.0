From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Mon, 25 Mar 2013 10:40:55 -0700
Subject: [PATCH v2 0/11] Qualcomm SSBI bus driver
In-Reply-To: <1363113716-25897-1-git-send-email-davidb@codeaurora.org>
References: <1362616187-21089-1-git-send-email-davidb@codeaurora.org>
 <1363113716-25897-1-git-send-email-davidb@codeaurora.org>
Message-ID: <20130325174055.GA8204@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 12, 2013 at 11:41:45AM -0700, David Brown wrote:
> This small series adds the Qualcomm SSBI bus driver.  The original
> driver was developed as part of Android.  Kenneth Heitke updated this,
> and sent it out a while back.  This series updates this driver to use
> DeviceTree, and fixes a few things that have changed since it was
> originally sent out.
> 
> In addition, the 11th patch, the RFC, is a small test driver that reads
> the version register off of the pm8058 device typically connected to
> an MSM8660 or MSM8960.  This is primarily useful to anyone wanting to
> work on these pmic drivers.
> 
> Updates to the PMIC drivers themselves to use this driver to come.

The first 10 now applied to my char/misc tree, thanks.

greg k-h
