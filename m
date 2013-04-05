From: tim@krieglstein.org (Tim Sander)
Date: Fri, 05 Apr 2013 08:13:02 +0200
Subject: 3.8 no mach include directory anymore?
Message-ID: <15525047.PsIxlFA1vB@dabox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

I have a small driver which uses the MX35_IO_ADDRESS which had been defined in
#include <mach/mx35.h>
but while the mx35.h file still exist the include directory has vanished?

Any idea how to get the module compiling again with 3.8?

Thanks
Tim
