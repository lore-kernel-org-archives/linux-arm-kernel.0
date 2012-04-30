From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Mon, 30 Apr 2012 08:52:14 +0200
Subject: [patch v2 3/3] kirkwood: Add iconnect support
In-Reply-To: <201204300011.17388.linux@baker-net.org.uk> (Adam Baker's message
 of "Mon, 30 Apr 2012 00:11:16 +0100")
References: <20120418211638.691400727@rtp-net.org>
 <201204252345.07721.linux@baker-net.org.uk>
 <87zk9yx04n.fsf@lebrac.rtp-net.org>
 <201204300011.17388.linux@baker-net.org.uk>
Message-ID: <878vhdbtk1.fsf@lebrac.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adam Baker <linux@baker-net.org.uk> writes:

Hi,

> On Thursday 26 April 2012, Arnaud Patard wrote:
>> Adam Baker <linux@baker-net.org.uk> writes:
>> 
>> Hi,
>> 
>> > On Wednesday 18 April 2012, Arnaud Patard wrote:
>> >> Add support for Iomega Iconnect system.
>> >> 
>> >> Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
>> > 
>> > Arnaud,
>> > 
>> > I have so far been unable to get a kernel to boot with your patches. I
>> > just get
>> > 
>> > Uncompressing Linux... done, booting the kernel.
>> 
>> hm. sounds weird. Are you sure that you have the DTB appended to your
>> kernel image ?
>
> Yes, if I don't append the DTB and I set ArcNumber to 1682 then it boots using 
> the ref board setup, if the DTB is appended then it doesn't boot (I configured 
> the kernel to support iconnect, dreamplug and RD-88F6281)

hm. ok. Can you provide your uImage/kernel config/modules/ and which
sources you've used... so that I can try to reproduce / boot your kernel?

Arnaud
