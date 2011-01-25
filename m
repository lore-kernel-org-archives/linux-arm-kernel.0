From: davidb@codeaurora.org (David Brown)
Date: Tue, 25 Jan 2011 11:20:51 -0800
Subject: [PATCH] msm: smd: Add smd_pkt driver
In-Reply-To: <1292437675-11561-1-git-send-email-nvishwan@codeaurora.org>
	(Niranjana Vishwanathapura's message of "Wed, 15 Dec 2010 10:27:55
	-0800")
References: <1292437675-11561-1-git-send-email-nvishwan@codeaurora.org>
Message-ID: <8yatygweqng.fsf@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 15 2010, Niranjana Vishwanathapura wrote:

> Add smd_pkt driver which provides device interface
> to smd packet ports.
>
> Signed-off-by: Niranjana Vishwanathapura <nvishwan@codeaurora.org>
> ---
>  drivers/char/Kconfig       |    8 +
>  drivers/char/Makefile      |    2 +
>  drivers/char/msm_smd_pkt.c |  466 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 476 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/char/msm_smd_pkt.c

Andrew, what's the proper destination for this change?  Should this go
into your tree?  Is there anything you want me to do with this change?

Thanks,
David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
