From: stern@rowland.harvard.edu (Alan Stern)
Date: Thu, 26 Oct 2017 11:06:08 -0400 (EDT)
Subject: [PATCH v2 1/3] usb: host: remove ehci-msm.c
In-Reply-To: <20171026134827.615-2-elder@linaro.org>
Message-ID: <Pine.LNX.4.44L0.1710261105090.1365-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 26 Oct 2017, Alex Elder wrote:

> No Qualcomm SoC requires the "ehci-msm.c" code any more.  So remove it.

What about old Qualcomm SoCs?  What should they use instead?

Alan Stern
