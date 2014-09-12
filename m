From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 12 Sep 2014 18:08:51 +0100
Subject: [PATCH 3.17-rc4 v5 2/6] arm: fiq: Replace default FIQ handler
In-Reply-To: <1410435078-28462-3-git-send-email-daniel.thompson@linaro.org>
References: <1410272111-30516-1-git-send-email-daniel.thompson@linaro.org>
 <1410435078-28462-1-git-send-email-daniel.thompson@linaro.org>
 <1410435078-28462-3-git-send-email-daniel.thompson@linaro.org>
Message-ID: <20140912170851.GN12361@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

And another thing...

On Thu, Sep 11, 2014 at 12:31:14PM +0100, Daniel Thompson wrote:
> +	.align 5
> +__fiq_abt:
> +	svc_entry 0, 0

Right, so this function is called __fiq_abt.
...
> +	svc_exit_via_fiq
> + UNWIND(.fnend		)
> +ENDPROC(__fiq_svc)

Or is it called __fiq_svc ?

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
