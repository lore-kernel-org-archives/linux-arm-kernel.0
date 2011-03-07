From: alberto@amarulasolutions.com (Alberto Panizzo)
Date: Mon, 07 Mar 2011 11:09:58 +0100
Subject: [PATCHv2 0/4] Continue the mx31_3ds machine support
Message-ID: <1299492598.2468.30.camel@realization>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

this series on top of Sascha's imx-for-2.6.39 branch continue the
support of peripherals for the machine mx31_3ds.

The first one fix also a kernel NULL pointer error introduced by
4d2f13be1e370a670c1cae20c194d5ce961e0fa5

In v2 all group of GPIO requests are packed with gpio_request_array

Best regards,
-- 
| Alberto Panizzo                                 Amarula Solutions BV |
| CTO  -  Founder                                      Cruquiuskade 47 |
| T. +31(0)851119171                              Amsterdam 1018 AM NL |
| F. +31(0)204106211                          www.amarulasolutions.com |
