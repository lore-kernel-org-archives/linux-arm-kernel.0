From: timur@codeaurora.org (Timur Tabi)
Date: Fri, 23 Oct 2015 16:54:34 -0500
Subject: [PATCH v13 5/5] uart: pl011: Add support to ZTE ZX296702 uart
In-Reply-To: <CABymUCOA3oG7Hq83hDyQ_uisQHeipoHshcWONWTtjxKvikzjsQ@mail.gmail.com>
References: <1438328959-16177-1-git-send-email-jun.nie@linaro.org>
 <1438328959-16177-6-git-send-email-jun.nie@linaro.org>
 <55FC16A2.5070207@arm.com>
 <CABymUCOA3oG7Hq83hDyQ_uisQHeipoHshcWONWTtjxKvikzjsQ@mail.gmail.com>
Message-ID: <CAOZdJXUjZLKkUYScD7oDTMuRUtAEJ6=DopmE4n6Vb9zyv+_viA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 19, 2015 at 1:54 AM, Jun Nie <jun.nie@linaro.org> wrote:
>
> I am not sure the silicon designer's plan on the UART IP. Different
> silicon team have different decision on the IP choice. So I guess
> future ZTE SOC may reuse ZTE UART per people assignment.

I would rather see this as a separate driver.  I think this patch
pollutes the amba-pl011.c driver too much.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
