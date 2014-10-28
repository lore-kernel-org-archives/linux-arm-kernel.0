From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 28 Oct 2014 12:42:54 +0000
Subject: [PATCH] arm64/dt: add machine name to kernel call stack dump
 output
In-Reply-To: <1414499060-6350-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1414499060-6350-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20141028124254.GC27405@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 28, 2014 at 01:24:20PM +0100, Ard Biesheuvel wrote:
> This installs the machine name as recorded by setup_machine_fdt()
> as dump stack arch description. This results in the string to be
> included in call stack dumps, as is shown here:

Thanks, I've just added this to ARM as well.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
