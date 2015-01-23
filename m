From: balbi@ti.com (Felipe Balbi)
Date: Fri, 23 Jan 2015 13:53:40 -0600
Subject: perf not capturing stack traces
In-Reply-To: <20150123195128.GE26557@saruman.tx.rr.com>
References: <20150123195128.GE26557@saruman.tx.rr.com>
Message-ID: <20150123195340.GF26557@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jan 23, 2015 at 01:51:28PM -0600, Felipe Balbi wrote:
> Hi,
> 
> I'm using v3.19-rc5 on an ARM Cortex A9 board. Unfortunately, perf is
> not able to capture any stack traces even though I CONFIG_STACKTRACE,
> CONFIG_FRAME_POINTER and CONFIG_ARM_UNWIND all enabled.
> 
> I wonder if anybody else is facing similar issues.
> 
> Here's console grab:

perf features:

Auto-detecting system features:
...                         dwarf: [ on  ]
...                         glibc: [ on  ]
...                          gtk2: [ OFF ]
...                      libaudit: [ on  ]
...                        libbfd: [ on  ]
...                        libelf: [ on  ]
...                       libnuma: [ OFF ]
...                       libperl: [ on  ]
...                     libpython: [ on  ]
...                      libslang: [ on  ]
...                     libunwind: [ on  ]
...            libdw-dwarf-unwind: [ on  ]
...                          zlib: [ on  ]
...     DWARF post unwind library: libunwind

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150123/b040cf76/attachment.sig>
