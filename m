From: dashie@sigpipe.me (Dashie)
Date: Thu, 9 Apr 2015 11:34:19 +0200
Subject: Building DTS, problem with includes
Message-ID: <2A6B56A6-CEF1-4616-B651-D0A00FC330E5@sigpipe.me>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I?ve re-started playing with my kirkwood board and still need to get a properly working DTB.

I?ve tried repos from :
  - arm-soc (for-next branch)
  - linus one from kernel.org git

With the two i got the error :
./dtc -I dts -O dtb ../kirkwood-verbatim-powerbay.dts
Error: ../kirkwood-verbatim-powerbay.dts:3.1-9 syntax error
FATAL ERROR: Unable to parse input tree

While line three is :
#include "kirkwood.dtsi"

I?ve got info that there is migration from /include/ to #include but i?ve tried the two DTC included in the sources without any success.

Any hints i?m missing here ?
