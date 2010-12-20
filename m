From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 20 Dec 2010 19:15:32 +0100
Subject: [PATCH 1/6 v8] ARM: Add basic architecture support for
	VIA/WonderMedia 85xx SoC's
In-Reply-To: <20101219174017.GA31832@alchark-u3s>
References: <1289147348-31969-1-git-send-email-alchark@gmail.com>
	<20101111234957.GA28735@n2100.arm.linux.org.uk>
	<20101219174017.GA31832@alchark-u3s>
Message-ID: <201012201915.32851.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 19 December 2010 18:40:17 Alexey Charkov wrote:
> This adds support for the family of Systems-on-Chip produced initially
> by VIA and now its subsidiary WonderMedia that have recently become
> widespread in lower-end Chinese ARM-based tablets and netbooks.
> 
> Support is included for both VT8500 and WM8505. Suitable code is
> selected (if compiled in) at early initialization time by reading a
> platform-specific identification register, as current bootloaders
> do not provide any reliable machine id to the kernel.
> 
> Included are basic machine initialization files, register and
> interrupt definitions, support for the on-chip interrupt controller,
> high-precision OS timer, GPIO lines, necessary macros for early debug,
> pulse-width-modulated outputs control, as well as platform device
> configurations for the specific drivers implemented elsewhere.
> 
> Signed-off-by: Alexey Charkov <alchark@gmail.com>

Looks good to me, thanks for addressing all my previous concerns.

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
