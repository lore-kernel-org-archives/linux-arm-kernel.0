From: khilman@linaro.org (Kevin Hilman)
Date: Wed, 19 Mar 2014 17:22:19 -0700
Subject: arm64: mainline with foundation model: hang in arm64_device_init
Message-ID: <7h7g7pen2c.fsf@paris.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

Should I expect vanilla mainline (v3.14-rc7) to work with the current
aarch64 foundation model r0p0 (model build 0.8.5206)?  I'm also using
the master branch of your boot-wrapper-aarch64 configured to point at
the mainline tree.

I've gotten as far as adding initcall_debug to the cmdline and noticing
that arm64_device_init never returns, but have to call it a day so have
to wait til tomorrow to debug further.  In the mean time wanted to check
with you on whether it should work.

Thanks,

Kevin
