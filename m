From: gnusercn@gmail.com (os user)
Date: Tue, 10 May 2011 13:45:45 +0800
Subject: Question about multi-bank memory usage in ARM platform
Message-ID: <BANLkTik2wzXouKNcBAJ6AJr0fjAuaOjwJw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell and list,

I have a question about multi-bank memory usage in ARM platform (arm926).

I have two banks of SDRAM, one is  64M at 0x20000000, another is
64M at 0x60000000. I tried to use both of them in Linux (2.6.38). I hope
the kernel will print

Memory: 128MB = 128MB total
Memory: 126236KB available (xxx code, xxx data, 112K init, 0K highmem)

So I tried passing 'mem=64M at 0x20000000 mem=64M at 0x60000000' to Kernel
command line.
