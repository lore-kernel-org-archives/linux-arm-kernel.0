From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 1 Feb 2012 17:05:16 -0700
Subject: [PATCH] gpio: samsung: adapt to changes in gpio specifier
 translator function declaration
In-Reply-To: <1328101352-22274-1-git-send-email-thomas.abraham@linaro.org>
References: <1328101352-22274-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <20120202000516.GA15343@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 01, 2012 at 06:32:32PM +0530, Thomas Abraham wrote:
> Commit 15c9a0acc3f7 (of: create of_phandle_args to simplify return of phandle
> parsing data) modifies the parameter list of of_xlate function pointer declaration
> in gpio_chip. Adapt the gpio specifier translate function for this change.
> 
> Reported-by: Tushar Behera <tushar.behera@linaro.org>
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>

Applied, thanks.

g.
