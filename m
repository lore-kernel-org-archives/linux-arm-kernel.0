From: B35083@freescale.com (Lu Jingchang-B35083)
Date: Tue, 4 Jun 2013 02:08:33 +0000
Subject: [PATCH v5] tty: serial: add Freescale lpuart driver support
In-Reply-To: <20130603172908.GA3272@kroah.com>
References: <1369893217-27809-1-git-send-email-b35083@freescale.com>
 <20130603172908.GA3272@kroah.com>
Message-ID: <B56CDBE15CE27145A4B77D2D24263E851CEF95@039-SN1MPN1-003.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> +config SERIAL_FSL_LPUART
>> +	bool "Freescale lpuart serial port support"
>
>Why can't this be built as a module?  I can't force users to only build
>this driver into the kernel, sorry.
[Lu Jingchang-B35083] 
  I'll enable the module support for this driver, thanks!
