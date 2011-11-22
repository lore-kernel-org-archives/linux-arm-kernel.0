From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 22 Nov 2011 09:48:21 +0000
Subject: [PATCH V3 2/6] ARM: s5p: remove useless churn in sleep.S
In-Reply-To: <1321954532-18724-3-git-send-email-amit.kachhap@linaro.org>
References: <1321954532-18724-1-git-send-email-amit.kachhap@linaro.org>
 <1321954532-18724-3-git-send-email-amit.kachhap@linaro.org>
Message-ID: <20111122094821.GU9581@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 22, 2011 at 03:05:28PM +0530, Amit Daniel Kachhap wrote:
> This patch cleans up sleep code in preparation for L2 resume code
> and hotplug functions

I wonder whether anyone read the comments in this file before they
changed the section for the code.
        /*
         * sleep magic, to allow the bootloader to check for an valid
         * image to resume to. Must be the first word before the
         * s3c_cpu_resume entry.
         */
