From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 22 May 2010 12:04:47 +0100
Subject: [PATCH 2/5] arm/orion5x: Base support for DNS-323 rev C1
In-Reply-To: <1274525686.1931.140.camel@pasglop>
References: <1274525686.1931.140.camel@pasglop>
Message-ID: <20100522110446.GB954@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 22, 2010 at 08:54:46PM +1000, Benjamin Herrenschmidt wrote:
>  static void __init dns323_init(void)
>  {
> +        console_loglevel = 10;
> +

Did you mean to leave this in?
