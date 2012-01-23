From: davidb@codeaurora.org (David Brown)
Date: Mon, 23 Jan 2012 07:58:51 -0800
Subject: [PATCH v2] spi: QUP based bus driver for Qualcomm MSM chipsets
In-Reply-To: <20120123104220.GV1068@n2100.arm.linux.org.uk>
References: <y> <1321307907-31508-1-git-send-email-harinij@codeaurora.org>
 <20120123104220.GV1068@n2100.arm.linux.org.uk>
Message-ID: <20120123155851.GA25417@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 23, 2012 at 10:42:20AM +0000, Russell King - ARM Linux wrote:
> Not specific to this patch, but I notice that you have in your headers:
> 
> In-Reply-To: <y>
> References: <y>
> 
> This is rather annoying, because it means that anyone else who has the
> same lines ends up having their messages attached to your messages as
> part of the same thread.
> 
> I think you need to read the documentation for git-send-email again -
> and check that you're using the arguments concerning message ids and
> threading correctly.

More specifically, when git-send-email promps for an email address or
a message id, realize it's not asking a yes or not question.  The
default it prints in brackets is what you get if you press enter.  If
you press 'y', the reply will be from 'y' as seen here.

David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
