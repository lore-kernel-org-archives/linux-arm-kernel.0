From: sw1-arm-linux@gmx.de (Stefan)
Date: Thu, 24 Jun 2010 15:44:31 +0200
Subject: NXP LPC3250 LCD controller
Message-ID: <201006241544.32140.sw1-arm-linux@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

there is an errata for NXP LPC3250 LCD controller.

****
3.4 LCD.1: Low throughput when LCD controller accesses DDR/SDRAM

Introduction:
The LCD controller is an AHB Master that uses an internal DMA controller
to transfer frame data from memory to the LCD panel.

Problem:
The time required to read data from either SDR or DDR SDRAM using the
LCD DMA controller takes longer than expected. ...
****

Does anybody know whether LCD with greater resolution then QVGA will 
definitely not work? 
(I'll use 480x272 24Bit) 

Or is there something I could fine tune in memory arbiter?

Has somebody a lager LCD than QVGA running on Linux with this SOC?

Thanks in advance 
Stefan
