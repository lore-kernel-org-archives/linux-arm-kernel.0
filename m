From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 27 Sep 2013 09:15:54 -0400
Subject: device tree binding documentation outdated
In-Reply-To: <20130926232907.GV12758@n2100.arm.linux.org.uk>
References: <20130926195158.GS12758@n2100.arm.linux.org.uk>
 <CAOMZO5ANsZGcpvmtBE7d0q0E6+f0bE_U8CBF7G2v3xtqoLbqcA@mail.gmail.com>
 <20130926205906.GT12758@n2100.arm.linux.org.uk>
 <CAHCPf3u9KyoJiAPv6oc_ZdVBqgix41__RAGRXh8z+d5bXO8fQw@mail.gmail.com>
 <20130926232907.GV12758@n2100.arm.linux.org.uk>
Message-ID: <20130927131554.GB31178@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

On Fri, Sep 27, 2013 at 12:29:07AM +0100, Russell King - ARM Linux wrote:
> I haven't sorted out a rootfs for this yet, so it fails trying to find
> that.  (Rabeeh's kernel contained an initramfs buildroot image - it
> might be useful to find some way to load that as a separate image -
> does appended DT support that?)

yes, point to it in your config, kbuild will build the initramfs in.
Appending the dtb and running mkimage has been working fine for me.

That's how I get to /sys/kernel/debug/pinctrl :)

thx,

Jason.
