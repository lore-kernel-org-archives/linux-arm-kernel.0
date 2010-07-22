From: ibr@radix50.net (Baurzhan Ismagulov)
Date: Thu, 22 Jul 2010 19:15:04 +0200
Subject: debugging kernel with gdb
In-Reply-To: <1279752261.15547.9.camel@qu102.quarc.com>
References: <4BFD72AD.4010005@gmail.com>
	<AANLkTikwrs3PUS2zNR8daxfVkSCKLUvRtDYkXicXcTXq@mail.gmail.com>
	<4BFD7BBF.1090100@gmail.com>
	<AANLkTikfGIBaYnFskW4_TUzfWXBIy9fIqziNcedQwE8M@mail.gmail.com>
	<1279752261.15547.9.camel@qu102.quarc.com>
Message-ID: <20100722171504.GA7869@radix50.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 21, 2010 at 03:44:21PM -0700, Jeff Hane wrote:
> The code was being compiled with -O2 and -g.  I thought the obvious
> thing to do is just change this to -O0 in the top level Makefile;
> however this results in the following message.   

This doesn't work (I've never looked why) and is not supported.

With kind regards,
Baurzhan.
