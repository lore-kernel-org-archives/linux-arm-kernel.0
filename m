From: ibr@radix50.net (Baurzhan Ismagulov)
Date: Wed, 28 Jul 2010 09:58:37 +0200
Subject: JPEG hw decoder
In-Reply-To: <AANLkTin4r_NrQbzXoTWoJJRCUXX9mjfgtrJ9yTPLW5_W@mail.gmail.com>
References: <AANLkTin4r_NrQbzXoTWoJJRCUXX9mjfgtrJ9yTPLW5_W@mail.gmail.com>
Message-ID: <20100728075837.GA14608@radix50.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 28, 2010 at 10:42:53AM +0530, rd bairva wrote:
>       My board has a hardware JPEG decoder. I want to write a driver
> for this in Linux kernel, But it seems there that no Framework exists
> in kernel. Can somebody provide me some pointers?

http://lwn.net/Kernel/LDD3/

You'd probably want to define the application interface using open /
read / write / ioctl / poll / close and implement them in a character
device.

With kind regards,
Baurzhan.
