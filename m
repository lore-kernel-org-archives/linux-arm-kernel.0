From: segher@kernel.crashing.org (Segher Boessenkool)
Date: Fri, 10 Feb 2012 18:25:09 +0100
Subject: hex number case in dts files.
In-Reply-To: <20120210002950.GA18408@codeaurora.org>
References: <20120209180411.GA5654@codeaurora.org>
 <4F340E71.7070004@gmail.com> <20120210001921.GA10536@truffala.fritz.box>
 <20120210002950.GA18408@codeaurora.org>
Message-ID: <7100D251-EE4E-4575-A1BD-96652638755B@kernel.crashing.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> What about number of digits?  Should a register at 0x42 be
> node at 00000042 or node at 42?  Again, I'm seeing both.

It depends on the binding of the parent node.  Most use no
leading zeroes except when representing 0 itself.


Segher
