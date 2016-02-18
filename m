From: peter@hurleysoftware.com (Peter Hurley)
Date: Thu, 18 Feb 2016 09:20:32 -0800
Subject: [PATCH 2/3] serial: xuartps: Enable OF earlycon support
In-Reply-To: <56C57A60.4070600@xilinx.com>
References: <67c9013fc61f53515934b54847a05df8b8e1504a.1455552315.git.michal.simek@xilinx.com>
 <23ab10a19b21df2ef17a5bb6ce2a70d2d3fd3551.1455552315.git.michal.simek@xilinx.com>
 <56C34F65.1040506@hurleysoftware.com> <56C57A60.4070600@xilinx.com>
Message-ID: <56C5FD60.4090906@hurleysoftware.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/18/2016 12:01 AM, Michal Simek wrote:
> BTW: Is it normal that when earlycon support is enabled that the bootlog
> is copied again? All what was printed before bootconsole [xxx] disabled
> is printed twice.

I think it has to do with the dummy console bug w/ OF.

Masahiro Yamada reported this back with 4.4-rc1 [1] but problem occurs before
then as well.

[1] http://www.gossamer-threads.com/lists/linux/kernel/2313050

> Or is this just bug in our driver?

No.

Regards,
Peter Hurley
