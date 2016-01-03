From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 3 Jan 2016 21:35:44 -0200
Subject: [PATCH] clk: fix clk-gpio.c with optional clock= DT property
In-Reply-To: <20160103105319.GB5779@n2100.arm.linux.org.uk>
References: <E1aFJ0A-00086Z-0I@rmk-PC.arm.linux.org.uk>
 <20160103064749.15239.59588@quark.deferred.io>
 <20160103105319.GB5779@n2100.arm.linux.org.uk>
Message-ID: <CAOMZO5C1zSWtLh-mE5pxZxDYEg3LEJNxnbkBOX69gGByy8=FDQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 3, 2016 at 8:53 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

>> That patch was merged into the clk tree in June 2015, based on 4.2-rc1.
>
> Interesting... I guess git describe is buggy then:
>
> $ git describe --contains 80eeb1f0f757

'git tag --contains' shows the correct response.

$ git tag --contains 80eeb1f0f757
v4.3
v4.3-rc1
v4.3-rc2
v4.3-rc3
v4.3-rc4
v4.3-rc5
v4.3-rc6
v4.3-rc7
v4.4-rc1
v4.4-rc2
v4.4-rc3
v4.4-rc4
v4.4-rc5
v4.4-rc6
v4.4-rc7
