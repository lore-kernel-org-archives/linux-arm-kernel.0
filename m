From: shhuiw@foxmail.com (=?ISO-8859-1?B?V2FuZyBTaGVuZy1IdWk=?=)
Date: Mon, 6 Jun 2016 12:36:56 +0800
Subject: No HAVE_PCI_MMAP defined for ARM64
Message-ID: <tencent_57130504654449F86744D3FD@qq.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

I see "HAVE_PCI_MMAP" is not defined in ARM64. That prevents me from running 
some nvme-cli commands on arm64 platform.

I googled and saw some patches have been submitted:
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-July/358906.html
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-July/269206.html

But they are not accepted into mainline. Any updated patches are available?

Thanks,
Sheng-Hui
