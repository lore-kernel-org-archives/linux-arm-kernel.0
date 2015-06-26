From: timur@codeaurora.org (Timur Tabi)
Date: Fri, 26 Jun 2015 14:28:38 -0500
Subject: [PATCH 1/3] hvc_dcc: bind driver to core0 for reads and writes
In-Reply-To: <1435344756-20901-1-git-send-email-timur@codeaurora.org>
References: <1435344756-20901-1-git-send-email-timur@codeaurora.org>
Message-ID: <CAOZdJXVHjhJLrxO6HCjHXLEJqxXum33B6RyRUZ5KBOu23setnA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 26, 2015 at 1:52 PM, Timur Tabi <timur@codeaurora.org> wrote:
>
> Selecting this option will enable code that serializes all console
> input and output to core 0.  The DCC driver will create input and
> output FIFOs that all cores will use.  Reads and writes from/to DCC
> are handled by a workqueue that runs only core 0.
>
> Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>

Somehow the original author got dropped when I made this patch.  This
patch should say:

From: Shanker Donthineni <shankerd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
