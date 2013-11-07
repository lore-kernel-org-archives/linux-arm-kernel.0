From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 7 Nov 2013 11:54:48 +0000
Subject: [PATCH 3/7] ARM: ux500: Remove ATAG support for SDI (MMC)
In-Reply-To: <20131107114654.GF16735@n2100.arm.linux.org.uk>
References: <1383732348-18576-1-git-send-email-lee.jones@linaro.org>
 <1383732348-18576-4-git-send-email-lee.jones@linaro.org>
 <20131107114654.GF16735@n2100.arm.linux.org.uk>
Message-ID: <20131107115448.GO30901@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 07 Nov 2013, Russell King - ARM Linux wrote:

> On Wed, Nov 06, 2013 at 10:05:44AM +0000, Lee Jones wrote:
> > This hasn't been used since we moved over to a Device Tree only platform.
> 
> The patch summary line is slightly off.  There's nothing here to do with
> ATAGs.

Oh I see. Yes you're right, it was just what Arnd, myself and a few
others called non-DT 'cos it was easier.

Linus are you happy to fixup the subject lines of these two commits or
would you like me to re-submit?

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
