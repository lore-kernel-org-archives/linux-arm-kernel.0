From: gregkh@linuxfoundation.org (Greg KH)
Date: Sat, 21 Dec 2013 13:11:58 -0800
Subject: [PATCH 3/5] drivers: net: APM X-Gene SoC Ethernet base driver
In-Reply-To: <1387597376-29303-4-git-send-email-isubramanian@apm.com>
References: <1387597376-29303-1-git-send-email-isubramanian@apm.com>
 <1387597376-29303-4-git-send-email-isubramanian@apm.com>
Message-ID: <20131221211158.GB30102@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 20, 2013 at 07:42:54PM -0800, Iyappan Subramanian wrote:
> Ethernet base device driver for APM X-Gene SoC.

Why is this a platform driver and not a bus driver for a xgene device?

thanks,

greg k-h
