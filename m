From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 16 Jul 2010 13:13:04 +0200
Subject: [PATCH v2][RFC] arm: Add basic support for VIA/WonderMedia SoC's
In-Reply-To: <20100715193136.GA19050@alchark-u3s.alchark.ru>
References: <20100712165025.GA13818@alchark-u3s.alchark.ru>
	<201007122122.32623.arnd@arndb.de>
	<20100715193136.GA19050@alchark-u3s.alchark.ru>
Message-ID: <201007161313.04667.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 15 July 2010, Alexey Charkov wrote:
> This adds basic support for machine initialization, interrupts, timers and
> serial console on VIA/WonderMedia VT8500 and WM8505 Systems-on-Chip.
> 
> These SoC's are used in quite many netbooks and tablets produced in China
> and sold online at relatively low prices (typically below 100 USD).
> 
> Support for WM8505 is known incomplete, while VT8500 is tested by me on the
> hardware and at least prints kernel messages to the serial console with timing
> information.
> 
> Signed-off-by: Alexey Charkov <alchark@gmail.com>
> ---
> 
> This is a second attempt, I tried to implement all the comments that I've
> received previously. Please comment and, if possible, integrate. Serial
> driver will follow separately.

No more comments from my side, looks good so far. I hope to get my toy
with this soon so I can try out the code.

	Arnd
