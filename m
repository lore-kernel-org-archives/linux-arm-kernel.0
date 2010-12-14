From: dan.j.williams@intel.com (Dan Williams)
Date: Tue, 14 Dec 2010 00:44:42 -0800
Subject: [PATCH] dmaengine: at_hdmac: fix buffer transfer size
	specification
In-Reply-To: <1292244521-20756-1-git-send-email-nicolas.ferre@atmel.com>
References: <1292244521-20756-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <AANLkTi=bpeyJL=ah1Fy9591EM8C+eF8-h6Tpbmq37JaC@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 13, 2010 at 4:48 AM, Nicolas Ferre <nicolas.ferre@atmel.com> wrote:
> Buffer transfer size is the number of transfers to be performed in
> relation with the width of the _source_ interface.
> So in the DMA_FROM_DEVICE case, it should be the register width that
> should be taken into account.
>
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---

Applied.
