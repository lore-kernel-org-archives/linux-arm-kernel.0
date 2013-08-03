From: olof@lixom.net (Olof Johansson)
Date: Fri, 2 Aug 2013 19:14:56 -0700
Subject: Build breakage due to latest ARM fixes
In-Reply-To: <20130803004838.GU23006@n2100.arm.linux.org.uk>
References: <CAOesGMgWeP-CdmOE-S7XZmJ-+1buP9a1cqavUns2gpgKrrhaxQ@mail.gmail.com>
 <20130803000731.GS23006@n2100.arm.linux.org.uk>
 <CAOesGMi3FBz7-tQSxgQMgHiHmPTnO4k57MkhQTQTvtB0Q6WyNw@mail.gmail.com>
 <20130803004111.GT23006@n2100.arm.linux.org.uk>
 <20130803004838.GU23006@n2100.arm.linux.org.uk>
Message-ID: <CAOesGMjCKD+1E_LTPbaEiLBC054nPcnXevXUtt5+OOYBqW6e-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 2, 2013 at 5:48 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

> Okay, this should fix it - *untested* though because of the fscking time
> it is here again.  The problem is that install_special_mapping() assumes
> that the pointer to the pages will be persistent, and it wasn't.  I found
> that during testing and thought I'd merged the patches in, but I seem to
> have totally destroyed the original fixes for this.

Ran it through my autobuilder/booter here, didn't fall over like without it.

Tested-by: Olof Johansson <olof@lixom.net>


-Olof
