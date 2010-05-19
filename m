From: ak10.iiita@gmail.com (Amit kumar)
Date: Thu, 20 May 2010 01:06:46 +0800
Subject: Support Question
In-Reply-To: <1274199223.1763.0.camel@ubuntu.ubuntu-domain>
References: <1274199223.1763.0.camel@ubuntu.ubuntu-domain>
Message-ID: <AANLkTin9qYxhbKe_ZDFvPbteM6Zn1H2M5jY6mAaH_Jxu@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Experts,

I am using SBC 9260 for development of a data acquisition platform. I am
using the SPI for data acquisition through 14 bit ADC slave. Currently
my board has debian 5.0 kernel version 2.6.30. I am using the spidriver
(spidev )for using the SPI on the board in master mode . Everything is
working fine and I am able to send and receive data . The only problem
is between the activation and deactivation of chip select.It takes
around 70microseconds for chipselect deactivation and then activation .
Since speed of my 4 channel ADC is 1MSPS so i need to bring down delay
as minimum as possible. I checked out the value of the registers
DLYBCS , DLYBCT , DLYBS and all are indicating the values 0.

Therefore I don;t have any idea from where the delay is being
introduced. Is it a problem of OS or there is nythng else involved .
Kindly guide me through this . I need urgent help .... any information
abt delay is welcome.

regards
amit
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100520/0642f52e/attachment.htm>
