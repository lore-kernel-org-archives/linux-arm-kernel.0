From: tixy@yxit.co.uk (Tixy)
Date: Tue, 29 Mar 2011 15:03:18 +0100
Subject: [PATCH] Fix ldrd/strd emulation for kprobes/ARM
In-Reply-To: <4D91E2A7.4040304@nokia.com>
References: <1301087944.2744.85.camel@computer2.home>
	<1301327765-6996-1-git-send-email-viktor.rosendahl@nokia.com>
	<1301403301.2519.125.camel@computer2.home> <4D91E2A7.4040304@nokia.com>
Message-ID: <1301407398.2519.153.camel@computer2.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2011-03-29 at 16:46 +0300, Viktor Rosendahl wrote:

> My patch was about fixing the correctness of the emulation regarding the 
> use of the PC register as Rn. To my understanding, this is a performance 
> optimization that will optimize the register/stack usage.

Yes, its a minor performance and size issue only. When reviewing the
changes I saw that they were adding a few memory accesses which could
have be avoided.

> I am not opposed to this in any way but I really think that fixing the 
> correctness and optimizing the performance should be in separate 
> patches. Also, I already submitted my patch to RMK's patch system, so 
> you are a bit late :)

Fair enough :-)

-- 
Tixy
