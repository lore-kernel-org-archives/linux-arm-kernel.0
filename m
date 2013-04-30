From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 30 Apr 2013 13:54:50 +0200
Subject: Latest build results - errors/warnings - lots of them
In-Reply-To: <20130430114229.GA2439@linaro.org>
References: <20130430081739.GP14496@n2100.arm.linux.org.uk>
 <201304301304.20650.arnd@arndb.de> <20130430114229.GA2439@linaro.org>
Message-ID: <201304301354.50210.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 30 April 2013, Dave Martin wrote:
> From 193f254689beaa1612d29bcc5ba004a933b37d95 Mon Sep 17 00:00:00 2001
> From: Dave Martin <dave.martin@linaro.org>
> Date: Tue, 30 Apr 2013 12:25:04 +0100
> Subject: [PATCH 1/3] ARM: mcpm: Add explicit AFLAGS to support v6/v7
>  multiplatform kernels
> 
> The full mcpm layer is not likely to be relevant to v6 based platforms,
> so a multiplatform kernel won't use that code if booted on v6 hardware.
> 
> This patch modifies the AFLAGS for affected mcpm .S files to specify
> armv7-a explicitly for that code.
> 
> Signed-off-by: Dave Martin <dave.martin@linaro.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>
