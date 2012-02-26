From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Sun, 26 Feb 2012 18:11:17 +0300
Subject: [PATCH 3/3] ARM: PXA27x: Zipit Z2: disable wake on GPIO0
In-Reply-To: <20120226142616.GM22562@n2100.arm.linux.org.uk>
References: <1330264062-5750-1-git-send-email-anarsoul@gmail.com>
 <1330264062-5750-3-git-send-email-anarsoul@gmail.com>
 <20120226142616.GM22562@n2100.arm.linux.org.uk>
Message-ID: <CA+E=qVdU-kDQYRD51TPRyj-SY4x7njdQ54Wy_wwOWdAue6Wjzg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/2/26 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Sun, Feb 26, 2012 at 04:47:42PM +0300, Vasily Khoruzhick wrote:
>> We don't want machine to wake up on AC state change
>
> NAK. ?Stop polluting the machine callback methods. ?Use the right one.

Ok, what's right one?
