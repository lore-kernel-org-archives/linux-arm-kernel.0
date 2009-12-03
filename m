From: acassis@gmail.com (Alan Carvalho de Assis)
Date: Thu, 3 Dec 2009 14:37:22 -0200
Subject: [PATCH 1/1] fix occasional ULPI timeouts with ehci-mxc
In-Reply-To: <20091203162939.GG29442@buzzloop.caiaq.de>
References: <1259770381-16987-1-git-send-email-valentin.longchamp@epfl.ch>
	<37367b3a0912021058j2801df5l2c937ac339bc5f6b@mail.gmail.com>
	<4B16C185.80905@warmcat.com>
	<37367b3a0912021225l67455ca2q2c7d0464279f446e@mail.gmail.com>
	<4B16D861.6090307@warmcat.com>
	<37367b3a0912030645m12db4f12j7991081e7d2bca00@mail.gmail.com>
	<4B17D104.4040800@warmcat.com>
	<37367b3a0912030821w22f72bd1tf200646e32da2158@mail.gmail.com>
	<20091203162939.GG29442@buzzloop.caiaq.de>
Message-ID: <37367b3a0912030837l7fa19aa4x6feff867fda87f30@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On 12/3/09, Daniel Mack <daniel@caiaq.de> wrote:
> On Thu, Dec 03, 2009 at 02:21:17PM -0200, Alan Carvalho de Assis wrote:
>> On 12/3/09, Andy Green <andy@warmcat.com> wrote:
>> >
>> > You're super welcome... glad that time spent wandering in the desert was
>> > able to help someone else in the end :-)
>> >
>>
>> Yes, it was a big saga, but finally it is working very nice.
>
> Good to hear :)
>
>> Now we need few things to get a good imx27 support in the kernel. I
>> think the camera and the VPU support are the most important drivers
>> missing.
>
> Do you have any patches ready for MX27 EHCI?
>

Yes, I'm preparing a patch to add usb support on TD60.

Best Regards,

Alan
