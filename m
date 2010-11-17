From: jonsmirl@gmail.com (jonsmirl at gmail.com)
Date: Wed, 17 Nov 2010 16:29:36 -0500
Subject: Calling conventions for IAR
Message-ID: <AANLkTikxL8qhzh=9DMkyJCVtAuWoq9Z__xj3up+KQhXA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently we are using the ARM gcc AAPCS calling conventions. I need
to call into an older ROM written with an IAR compiler. Can I decorate
the function declarations for older calling conventions like I do on
x86 (_fastcall, _cdelc, _stdcall, etc)? I can't figure out the right
thing to search for, what's a good keyword?

-- 
Jon Smirl
jonsmirl at gmail.com
