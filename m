From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Tue, 27 Aug 2013 17:25:23 +0200
Subject: linux-next: manual merge of the arm-soc tree with the usb tree
In-Reply-To: <878uznxjnl.fsf@linaro.org>
References: <20130827181353.319c150858829df1bb68d60b@canb.auug.org.au>
 <521C6961.9020103@linutronix.de>
 <CABxcv=mg6t5wPqpF3j5sr_76qfZ7N7KgpWhcKSGoPTOcaR=V6A@mail.gmail.com>
 <521CA888.1080909@baylibre.com> <521CAF59.1090203@linutronix.de>
 <521CB046.9070408@baylibre.com> <878uznxjnl.fsf@linaro.org>
Message-ID: <521CC4E3.8030204@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/27/2013 05:01 PM, Kevin Hilman wrote:
>>> What do we do now?
>>
>> Cannot you just merge the stable arm-soc/dt branch into your branch
>> before applying your patches?
> 
> Unfortunately, the next/dt branch of arm-soc is not necessarily stable
> so should *not* be merged.  In fact none of the arm-soc branches should
> be considered stable.
> 
> As was already mentioned, this should be split up into driver changes
> and DTS changes through arm-soc.  They'll both merge for v3.12.

But splitting will break the driver until .dts & code is in sync again.

> BTW, how did this patch get merged without a signoff/ack from the OMAP
> DT maintainer in the first place?  Hmm, looks like Benoit was not copied
> nor was linux-omap or linux-arm-kernel copied in the original mails.

Hmm. I had Benoit's okay [0] to do the change "as long as Felipe is
fine with it". I indeed forgot to Cc Benoit on the dts changes.
For the phy-rename Felipe pinged you and we did the topic-branch, here
I forgot.

> 
> Kevin

[0] http://www.spinics.net/lists/linux-usb/msg88423.html

Sebastian
