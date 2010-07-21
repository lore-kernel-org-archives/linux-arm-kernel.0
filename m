From: jeff.hane@maxim-ic.com (Jeff Hane)
Date: Wed, 21 Jul 2010 15:44:21 -0700
Subject: debugging kernel with gdb
In-Reply-To: <AANLkTikfGIBaYnFskW4_TUzfWXBIy9fIqziNcedQwE8M@mail.gmail.com>
References: <4BFD72AD.4010005@gmail.com>
	<AANLkTikwrs3PUS2zNR8daxfVkSCKLUvRtDYkXicXcTXq@mail.gmail.com>
	<4BFD7BBF.1090100@gmail.com>
	<AANLkTikfGIBaYnFskW4_TUzfWXBIy9fIqziNcedQwE8M@mail.gmail.com>
Message-ID: <1279752261.15547.9.camel@qu102.quarc.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

 I'm bringing up a new chip with an ARM1136 and trying to step thru the
code with gdb but because it's been optimized it's not working so well.
The code was being compiled with -O2 and -g.  I thought the obvious
thing to do is just change this to -O0 in the top level Makefile;
however this results in the following message.   

Error: selected processor does not support `ldrexb


 I'm trying to figure out if optimization can't be turned off or if I
have some issue with my toolchain. 

thanks,
jeff
