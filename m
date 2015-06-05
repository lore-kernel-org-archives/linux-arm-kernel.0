From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 05 Jun 2015 14:33:33 +0200
Subject: [RFC] arm: Add for atomic half word exchange
In-Reply-To: <274749765.566061433467033693.JavaMail.weblogic@epmlwas07c>
References: <274749765.566061433467033693.JavaMail.weblogic@epmlwas07c>
Message-ID: <7355143.I0WcWX47Z6@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 05 June 2015 01:17:13 Sarbojit Ganguly wrote:
> Since the compilation is also a success for CONFIG_CPU_V6 with the patch,
> I think we're good to go.

I'm not following your logic. Did you create a new patch that addresses
compilation with CONFIG_CPU_V6?

The original patch should cause a compile error on v6, if it does not,
you either have a broken assembler or you forgot to enable the code
that uses these instructions. Neither of them would be a reason to
merge the patch. Please explain what is going on.

	Arnd
