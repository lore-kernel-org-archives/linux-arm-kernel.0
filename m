From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 25 Oct 2012 14:21:44 +0000
Subject: [PATCH v4] pwm: vt8500: Update vt8500 PWM driver support
In-Reply-To: <1351100330-26072-1-git-send-email-linux@prisktech.co.nz>
References: <1351100330-26072-1-git-send-email-linux@prisktech.co.nz>
Message-ID: <201210251421.44474.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 24 October 2012, Tony Prisk wrote:
> This patch updates pwm-vt8500.c to support devicetree probing and
> make use of the common clock subsystem.
> 
> A binding document describing the PWM controller found on
> arch-vt8500 is also included.
> 
> Signed-off-by: Tony Prisk <linux@prisktech.co.nz>

Acked-by: Arnd Bergmann <arnd@arndb.de>
