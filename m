From: davidb@codeaurora.org (David Brown)
Date: Thu, 15 Dec 2011 10:14:50 -0800
Subject: [PATCH v4 REPOST 2/5] ARM: SMP: Refactor Kconfig to be more
 maintainable
In-Reply-To: <1323862781-3465-3-git-send-email-dave.martin@linaro.org>
References: <1323862781-3465-1-git-send-email-dave.martin@linaro.org>
 <1323862781-3465-3-git-send-email-dave.martin@linaro.org>
Message-ID: <20111215181450.GA22330@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 14, 2011 at 11:39:38AM +0000, Dave Martin wrote:
> Making SMP depend on (huge list of MACH_ and ARCH_ configs) is
> bothersome to maintain and likely to lead to merge conflicts.
> 
> This patch moves the knowledge of which platforms are SMP-capable
> to the individual machines.  To enable this, a new HAVE_SMP config
> option is introduced to allow machines to indicate that they can
> run in a SMP configuration.

There still seem to be several people and lists from the
get_maintainer.pl output that are missing.  Russell should be
included, as well as the MSM maintainers and that list.

David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
