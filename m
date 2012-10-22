From: motumboe@gmail.com (Marco Lazzaroni)
Date: Mon, 22 Oct 2012 18:33:33 +0200
Subject: Retry writes on MMC/SD
Message-ID: <5085755D.2060400@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,
   because of an unreliable hardware, writes to a SD Card fail every now 
and then, and I get error -84 (EILSEQ).
Is there a way to retry writing a sector if it fails? Is there a number 
of retries to set somewhere? If not, how could this be implemented?
Thanks.
Best regards,
   Marco Lazzaroni
