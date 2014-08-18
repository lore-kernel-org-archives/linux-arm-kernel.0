From: olof@lixom.net (Olof Johansson)
Date: Mon, 18 Aug 2014 12:08:29 -0700
Subject: [PATCH] MAINTAINERS: Add entry for SOC Qualcomm drivers
In-Reply-To: <1408387131-32152-1-git-send-email-agross@codeaurora.org>
References: <1408387131-32152-1-git-send-email-agross@codeaurora.org>
Message-ID: <CAOesGMi1RsP=L2BG5kUfnnjD5B7kW_SDDDiqRrEuY7RvS8HyyA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 18, 2014 at 11:38 AM, Andy Gross <agross@codeaurora.org> wrote:
> This patch adds a MAINTAINERS entry for the SOC Qualcomm drivers.
>
> Signed-off-by: Andy Gross <agross@codeaurora.org>

Hm. I always figured the drivers/soc/<platform> hierarchy would be
maintained by the subplatform maintainers, not by other developers.
Main thought behind that was that we might want to cause a bit of
bottle neck here, to make sure that at least one person has the full
picture of what's going on across the platform as a whole.

That doesn't mean it _has_ to be that way though. And I'll leave it up
to Kumar to decide for his platform. I.e. this would need an ack from
him.


-Olof
