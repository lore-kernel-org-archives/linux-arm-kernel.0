From: peter.maydell@linaro.org (Peter Maydell)
Date: Thu, 8 Sep 2011 13:01:49 +0100
Subject: [Android-virt] KVM ARM interrupt virtualization
In-Reply-To: <4E6899B5.70608@gmail.com>
References: <CAOMgcGJoF74=q4uzuC+FGQYP3QiLEZvC+duJDAt0m8et8zmCqA@mail.gmail.com>
	<CAHkRjk6Vm2yNLm8Gzk3+4mYAfiXVjufv2xc0Kc-6ac-oS4zytw@mail.gmail.com>
	<CAOMgcGJBoeKJ8FjDW9eESfT+FiXmFF9PfShJ=a2adbESLD2YkA@mail.gmail.com>
	<20110908085449.GA29243@e102109-lin.cambridge.arm.com>
	<4E6899B5.70608@gmail.com>
Message-ID: <CAFEAcA8=mGUP0dXTNXM6y9RDtWWEkJ2YhuavMBW-3BFfbOPS0g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 September 2011 11:32, bill4carson <bill4carson@gmail.com> wrote:
> There is much more involved if I want to use A15 as Guest OS,
> cause Qemu haven't got any A15 support yet.

In the interests of not accidentally duplicating work, I should
mention that QEMU A15 work is on my (Linaro) todo list; basically
I'm thinking in terms of adding enough support to boot an A15
Linux guest, but not actually implementing emulation of the
virtualization/LPAE extensions. If you'd like to do some of the
work here we should probably coordinate on that...

The Fast Model Versatile Express platform (including its memory
map) is documented here:
http://infocenter.arm.com/help/topic/com.arm.doc.dui0423j/BEIEAGAA.html

The memory maps (legacy A9 and "Cortex A-Series") for VE
hardware are here:
http://infocenter.arm.com/help/topic/com.arm.doc.dui0447e/CACIHGFE.html

-- PMM
