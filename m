From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 25 Feb 2014 22:56:25 +0100
Subject: [PATCH] ARM: move __fixup_smp out of init section
In-Reply-To: <CAL_JsqLo+FPm0u-2TxN6OnT_JJDyx7evfY1SPAw0ratmm_TBAw@mail.gmail.com>
References: <1393352193-31717-1-git-send-email-robherring2@gmail.com>
 <5546770.Bku2iJMdOj@wuerfel>
 <CAL_JsqLo+FPm0u-2TxN6OnT_JJDyx7evfY1SPAw0ratmm_TBAw@mail.gmail.com>
Message-ID: <6010058.epcA2Vh4jE@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 25 February 2014 15:46:15 Rob Herring wrote:
> 
> It's the arm cross compiler in ubuntu 13.10:
> 
> $ arm-linux-gnueabihf-ld -v
> GNU ld (GNU Binutils for Ubuntu) 2.23.52.20130913
> $ arm-linux-gnueabihf-gcc -v
> gcc version 4.8.1 (Ubuntu/Linaro 4.8.1-10ubuntu7)
> 

Ok, I'm using the exact same one here.

	Arnd
