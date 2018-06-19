From: linux@roeck-us.net (Guenter Roeck)
Date: Tue, 19 Jun 2018 10:14:24 -0700
Subject: [RFC PATCH] ARM: Use logical or instead of addition for badr
 address calculation
In-Reply-To: <20180619151235.GH17671@n2100.armlinux.org.uk>
References: <1529384828-2452-1-git-send-email-linux@roeck-us.net>
 <CAKv+Gu8Byj7G3Awnq4Y90Wot=GJTx0gO5A7-960au9ZkBBL2=A@mail.gmail.com>
 <b8bff03d-91a7-0e53-a44e-d1924beb382d@roeck-us.net>
 <CAKv+Gu-T8Fx3Nry7pUdOoOeRU-Ns89w3oo4itmu1q4FzYF5Rag@mail.gmail.com>
 <20180619151235.GH17671@n2100.armlinux.org.uk>
Message-ID: <20180619171424.GA16846@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 19, 2018 at 04:12:35PM +0100, Russell King - ARM Linux wrote:
> 
> So, I'm going to continue sitting on the fence on this, and basically
> take the attitude that it's better that people don't use the new
> binutils until binutils people can provide us with an officially
> sanctioned solution that's going to work for both older and future
> assemblers.
> 
I would so much love if people were working together instead of against
each other :-(. Never mind, I'll try a toolchain with binutils 2.28.1.
At least that is still supported with buildroot.

Guenter
