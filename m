From: gregkh@linuxfoundation.org (Greg KH)
Date: Fri, 3 Apr 2015 16:28:59 +0200
Subject: [PATCH 2/6] selftest/kdbus: enable cross compilation
In-Reply-To: <1427930420-4762-3-git-send-email-tyler.baker@linaro.org>
References: <1427930420-4762-1-git-send-email-tyler.baker@linaro.org>
 <1427930420-4762-3-git-send-email-tyler.baker@linaro.org>
Message-ID: <20150403142859.GA4579@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 01, 2015 at 04:20:16PM -0700, Tyler Baker wrote:
> Use the CC variable instead of hard coding gcc and include lib.mk.
> 
> Signed-off-by: Tyler Baker <tyler.baker@linaro.org>
> Acked-by: Shuah Khan <shuahkh@osg.samsung.com>
> ---
>  tools/testing/selftests/kdbus/Makefile | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Applied to my kdbus branch, thanks.

greg k-h
