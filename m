From: davidb@codeaurora.org (David Brown)
Date: Thu, 19 Apr 2012 17:28:02 -0700
Subject: [PATCH] ARM: MSM: Remove twice included header files
In-Reply-To: <1334338384-10728-1-git-send-email-thomas@tomweber.eu>
References: <1334338384-10728-1-git-send-email-thomas@tomweber.eu>
Message-ID: <20120420002802.GA8441@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 13, 2012 at 07:33:04PM +0200, Thomas Weber wrote:
> Remove twice included gpio.h in board-msm7x30
> and board-qsd8x50.

This was alread reported in https://lkml.org/lkml/2012/2/15/344

Please make sure you use the MAINTAINERS file
(scripts/get_maintainer.pl helps here) so that the right people are
included.  The patch should be sent To the maintainers, and the list
CC'd.

I've pulled the previous version of the patch in so it will get
included in 3.5.

David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
