From: nvishwan@codeaurora.org (nvishwan at codeaurora.org)
Date: Tue, 21 Dec 2010 15:45:12 -0800 (PST)
Subject: [PATCH] msm: rmnet: msm rmnet smd virtual ethernet driver
In-Reply-To: <20101215134135.51df5a7f@nehalam>
References: <1292437866-11652-1-git-send-email-nvishwan@codeaurora.org>
	<20101215134135.51df5a7f@nehalam>
Message-ID: <9eecc86d79182bb887f241f7367de068.squirrel@www.codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Wed, 15 Dec 2010 10:31:06 -0800
> Niranjana Vishwanathapura <nvishwan@codeaurora.org> wrote:
>
>> +
>> +static void rmnet_tx_timeout(struct net_device *dev)
>> +{
>> +	pr_info("rmnet_tx_timeout()\n");
>> +}
>
> The purpose of having a tx_timeout is to clear the pending
> request.
>
> --
>

Currently, there is no mechanism to clear the transaction.  This message
is helpful in identifying the issue and fixing it.
