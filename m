From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Mon, 19 Jul 2010 22:02:12 +0200
Subject: [PATCH] ARM: Add SWP/SWPB emulation for ARMv7 processors (v6)
In-Reply-To: <20100719194940.GA14766@shutemov.name>
References: <20100719180136.20305.7333.stgit@e200687-lin>
	<20100719194940.GA14766@shutemov.name>
Message-ID: <AANLkTik3CSSQLqajFimJxbq8TFBQ6iVx3RtdC9ObVj2-@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/7/19 Kirill A. Shutemov <kirill@shutemov.name>:

> Why do we need this? Why do not just fix broken programs?

People tend to use some third-party precompiled binaries, some of
them compiled with a compiler using SWP.

A typical example is the CDC Java runtime, JRE.

Yours,
Linus Walleij
