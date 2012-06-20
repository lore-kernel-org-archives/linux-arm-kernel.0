From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 20 Jun 2012 00:26:48 -0300
Subject: [RFC] Support for 'Coda' video codec IP.
In-Reply-To: <1340115094-859-1-git-send-email-javier.martin@vista-silicon.com>
References: <1340115094-859-1-git-send-email-javier.martin@vista-silicon.com>
Message-ID: <CAOMZO5AOEdVpSvV2bnbw6bwGb8+83Zji3jkTjH01yaC7pZUGvA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Javier,

On Tue, Jun 19, 2012 at 11:11 AM, Javier Martin
<javier.martin@vista-silicon.com> wrote:
> This patch adds support for the video encoder present
> in the i.MX27. It currently support encoding in H.264 and
> in MPEG4 SP. It's working properly in a Visstrim SM10 platform.
> It uses V4L2-mem2mem framework.
>
> A public git repository is available too:
> git://github.com/jmartinc/video_visstrim.git

I will give it a try and I have some questions:

- How did you generate the VPU firmware?

- Which userspace application did you use for testing the encoding? Is
Gstreamer OK to test it?

Thanks,

Fabio Estevam
