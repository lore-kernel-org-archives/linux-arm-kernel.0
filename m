From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 28 Apr 2017 17:14:03 +0100
Subject: [PATCH] arm64: Print DT machine model in setup_machine_fdt()
In-Reply-To: <1493296385-14140-1-git-send-email-geert+renesas@glider.be>
References: <1493296385-14140-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20170428161403.GF6368@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 27, 2017 at 02:33:05PM +0200, Geert Uytterhoeven wrote:
> On arm32, the machine model specified in the device tree is printed
> during boot-up, courtesy of of_flat_dt_match_machine().
> 
> On arm64, of_flat_dt_match_machine() is not called, and the machine
> model information is not available from the kernel log.
> 
> Print the machine model to make it easier to derive the machine model
> from an arbitrary kernel boot log.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied. Thanks.

-- 
Catalin
