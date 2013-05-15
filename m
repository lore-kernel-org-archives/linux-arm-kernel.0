From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 15 May 2013 18:56:05 +0200
Subject: [PATCH 08/39] dmaengine: ste_dma40: Remove redundant address
 fetching function
In-Reply-To: <1368611522-9984-9-git-send-email-lee.jones@linaro.org>
References: <1368611522-9984-1-git-send-email-lee.jones@linaro.org>
 <1368611522-9984-9-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdZpx3=8dhGaZ9xW7vXTmvhi=OVE5vFCAW66-AnwV_i=rQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 15, 2013 at 11:51 AM, Lee Jones <lee.jones@linaro.org> wrote:

> Addresses are now stored in local data structures and are easy to
> obtain, thus a specialist function used to fetch them is now surplus
> to requirement.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Patch tentatively applied, waiting for Vinod's ACK.

Yours,
Linus Walleij
