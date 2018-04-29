From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Sun, 29 Apr 2018 15:35:54 +0200
Subject: [PATCH 07/11] driver core: Respect all error codes from
 dev_pm_domain_attach()
In-Reply-To: <1524732790-2234-8-git-send-email-ulf.hansson@linaro.org>
References: <1524732790-2234-1-git-send-email-ulf.hansson@linaro.org>
 <1524732790-2234-8-git-send-email-ulf.hansson@linaro.org>
Message-ID: <20180429133554.GB28913@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 26, 2018 at 10:53:06AM +0200, Ulf Hansson wrote:
> The limitation of being able to check only for -EPROBE_DEFER from
> dev_pm_domain_attach() has been removed. Hence let's respect all error
> codes and bail out accordingly.

If that is really true, nice job!

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
