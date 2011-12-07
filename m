From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 7 Dec 2011 11:34:54 +0000
Subject: [RFC v2 1/2] dma-buf: Introduce dma buffer sharing mechanism
In-Reply-To: <CAB2ybb9yiHLzB9iW_EhBvEkvo3n82phkfS+d1J7yXi+ZZt=kDw@mail.gmail.com>
References: <1322816252-19955-1-git-send-email-sumit.semwal@ti.com>
 <201112071011.03525.arnd@arndb.de>
 <CAB2ybb9yiHLzB9iW_EhBvEkvo3n82phkfS+d1J7yXi+ZZt=kDw@mail.gmail.com>
Message-ID: <201112071134.54352.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 07 December 2011, Semwal, Sumit wrote:
> Right; that would be ideal, but we may not be able to ask each user to
> do so - especially when the sharing part might be interspersed in
> existing buffer handling code. So for now, I would like to keep it as
> it-is.

Ok, fair enough. It certainly doesn't hurt.

	Arnd
