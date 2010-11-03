From: Jession.Dai@BENQ.com (Jession Dai)
Date: Wed, 3 Nov 2010 22:39:02 +0800
Subject: [PATCH v2 1/4] ARM: S5PV210: Add gpio interrupt support
Message-ID: <6D163D12F822044EA4FE725D2268858A07A02E72@BQC-MSV11.BQC.CORP.COM>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dears:

         I am looking for help about GPIO interrupt number.

 

Issue:

The interrupt pin of an IC is connected to ARM (s5pc100) with pin
GPJ2_1, when I want to register interrupt with the 

 request_irq(Int_number,
taos_probe_hndlr,IRQF_TRIGGER_FALLING,DEVICE_NAME,NULL));

but ,now I can't get the interrupt number(Int_number) in advance.

 

According to the spec of s5pc100, the interrupt number may be 30 ?
here, I want to ask for your help 

 

IC.INT------>ARM.GPJ2_1  (connection symbol)

 

Many Thanks !! 

 

Best Regards, 

Jession.Dai

*********************************************

HM1 Dep.  BenQ Co., Ltd.
268# Shishan Road, New District, Suzhou, China 

TEL: +86-512-68078800-6098
FAX: +86-512-68078800-6078 
E-mail: jession.dai at BenQ.com <mailto:jession.daii@BenQ.com> 

********************************************* 

 

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101103/42cb3b87/attachment-0001.html>
