From: acassis@gmail.com (Alan Carvalho de Assis)
Date: Thu, 3 Dec 2009 14:21:17 -0200
Subject: [PATCH 1/1] fix occasional ULPI timeouts with ehci-mxc
In-Reply-To: <4B17D104.4040800@warmcat.com>
References: <1259770381-16987-1-git-send-email-valentin.longchamp@epfl.ch>
	<37367b3a0912021058j2801df5l2c937ac339bc5f6b@mail.gmail.com>
	<4B16C185.80905@warmcat.com>
	<37367b3a0912021225l67455ca2q2c7d0464279f446e@mail.gmail.com>
	<4B16D861.6090307@warmcat.com>
	<37367b3a0912030645m12db4f12j7991081e7d2bca00@mail.gmail.com>
	<4B17D104.4040800@warmcat.com>
Message-ID: <37367b3a0912030821w22f72bd1tf200646e32da2158@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/3/09, Andy Green <andy@warmcat.com> wrote:
>
> You're super welcome... glad that time spent wandering in the desert was
> able to help someone else in the end :-)
>

Yes, it was a big saga, but finally it is working very nice.

Now we need few things to get a good imx27 support in the kernel. I
think the camera and the VPU support are the most important drivers
missing.

I think mx1_camera.c could be modified to support mx27 CSI, but to the
VPU I have no idea.

Best Regards,

Alan
