From: davidb@codeaurora.org (David Brown)
Date: Mon, 28 Mar 2011 11:48:14 -0700
Subject: [PATCH 1/2] msm: clock: Support dummy clocks
In-Reply-To: <1301009686-4042-2-git-send-email-sboyd@codeaurora.org> (Stephen
	Boyd's message of "Thu, 24 Mar 2011 16:34:45 -0700")
References: <1301009686-4042-1-git-send-email-sboyd@codeaurora.org>
	<1301009686-4042-2-git-send-email-sboyd@codeaurora.org>
Message-ID: <8yamxkfw07l.fsf@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 24 2011, Stephen Boyd wrote:

> Implement a dummy clock driver and macro in the spirit of
> CLK_PCOM(). This is useful on targets where a pclk doesn't exist
> and we want to keep drivers sane by providing such clocks.
>
> Change-Id: Iad37f6e5f19052127814934cf7484971fdb4fcda

Please remember to remove any 'Change-Id' lines before posting patches.
I'll pull these out of these patches.

David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
