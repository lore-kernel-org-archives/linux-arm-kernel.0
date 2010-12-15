From: shemminger@vyatta.com (Stephen Hemminger)
Date: Wed, 15 Dec 2010 13:41:35 -0800
Subject: [PATCH] msm: rmnet: msm rmnet smd virtual ethernet driver
In-Reply-To: <1292437866-11652-1-git-send-email-nvishwan@codeaurora.org>
References: <1292437866-11652-1-git-send-email-nvishwan@codeaurora.org>
Message-ID: <20101215134135.51df5a7f@nehalam>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 15 Dec 2010 10:31:06 -0800
Niranjana Vishwanathapura <nvishwan@codeaurora.org> wrote:

> +
> +static void rmnet_tx_timeout(struct net_device *dev)
> +{
> +	pr_info("rmnet_tx_timeout()\n");
> +}

The purpose of having a tx_timeout is to clear the pending
request.

-- 
