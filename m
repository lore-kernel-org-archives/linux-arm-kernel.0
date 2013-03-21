From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 21 Mar 2013 12:49:43 +0100
Subject: [PATCH v4 2/2] i2c: pxa: Use i2c-core to get bus number now
In-Reply-To: <1362157052-16738-3-git-send-email-dianders@chromium.org>
References: <1360630085-26874-1-git-send-email-dianders@chromium.org>
 <1362157052-16738-1-git-send-email-dianders@chromium.org>
 <1362157052-16738-3-git-send-email-dianders@chromium.org>
Message-ID: <20130321114943.GH19297@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 01, 2013 at 08:57:32AM -0800, Doug Anderson wrote:
> The commit: "i2c-core: dt: Pick i2c bus number from i2c alias if
> present" adds support for automatically picking the bus number based
> on the alias ID.  Remove the now unnecessary code from i2c-pxa that
> did the same thing.
> 
> Signed-off-by: Doug Anderson <dianders@chromium.org>

Thanks, applied for-next.
