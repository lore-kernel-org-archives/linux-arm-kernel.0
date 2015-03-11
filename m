From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 11 Mar 2015 20:54:21 +0100
Subject: [GIT PULL] at91: fixes for 4.0 #3
In-Reply-To: <1426086048-25681-1-git-send-email-nicolas.ferre@atmel.com>
References: <1426086048-25681-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <5544711.gEBcvXK33N@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 11 March 2015 16:00:48 Nicolas Ferre wrote:
> Arnd, Olof, Kevin,
> 
> Some fixes for 4.0. Most of them are for USB and some issues that we hit with
> the clocks. The cleanup of the cpu_is_at91xxxx() macros for multi-platform led
> to rework some USB compatibility strings to handle particularities of some SoCs.
> A compilation error in case of thumb2 kernel build is also solved.
> 
Pulled into fixes, thanks!

	Arnd
