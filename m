From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 20 May 2015 10:21:44 -0300
Subject: imx53 IPU support on 4.0.4
In-Reply-To: <555C86A5.2030007@melag.de>
References: <555C86A5.2030007@melag.de>
Message-ID: <CAOMZO5CTz4DOdB6xvrw1=i4DRsukQjtzyDMJn50znXd6uXMBUA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Enrico,

On Wed, May 20, 2015 at 10:05 AM, Enrico Weigelt, metux IT consult
<weigelt@melag.de> wrote:
>
> Hi folks,
>
>
> I've rebased the IPUv3 patches from ptx folks onto 4.0.4,
> working good for me. (now gst plays h264 @25fps on imx53)
>
> https://github.com/metux/linux/commits/submit-4.0-imx53-ipuv3

That's great.

Kamil mentioned that the scaler patches should be merged via the the
gpu subsystem:
http://www.spinics.net/lists/linux-media/msg88582.html

,so I guess Phillip will handle it.

>
> (Haven't 4.1rc* yet, as it broke some other things for me.)

What are the regressions you see?

Regards,

Fabio Estevam
