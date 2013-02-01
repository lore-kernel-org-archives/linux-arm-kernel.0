From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 1 Feb 2013 10:46:26 +0000
Subject: [PATCH v4] arm: use built-in byte swap function
In-Reply-To: <20130131183747.d56289dbd89b165cf12a9d28@freescale.com>
References: <1359478014.3529.157.camel@shinybook.infradead.org>
 <20130129174249.GB25415@pd.tnic>
 <1359482147.3529.161.camel@shinybook.infradead.org>
 <20130129181046.GC25415@pd.tnic>
 <1359541333.3529.186.camel@shinybook.infradead.org>
 <20130130200900.9d7cf7908caeaef4ecee1d61@freescale.com>
 <20130131092801.GV23505@n2100.arm.linux.org.uk>
 <20130131145947.f62474a0600848df86548b96@freescale.com>
 <1359670248.27468.13.camel@shinybook.infradead.org>
 <20130131183747.d56289dbd89b165cf12a9d28@freescale.com>
Message-ID: <20130201104626.GH23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 31, 2013 at 06:37:47PM -0600, Kim Phillips wrote:
> +#if GCC_VERSION >= 40600
> +#define __HAVE_BUILTIN_BSWAP32__
> +#define __HAVE_BUILTIN_BSWAP64__

You really aren't listening to anything that's been said to you.
