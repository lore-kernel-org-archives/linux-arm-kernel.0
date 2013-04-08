From: mchehab@redhat.com (Mauro Carvalho Chehab)
Date: Mon, 8 Apr 2013 07:56:06 -0300
Subject: [PATCH v8 0/2] ARM: davinci: dm355: add support for vpbe display
In-Reply-To: <51629DA8.3040806@ti.com>
References: <1365413215-3632-1-git-send-email-prabhakar.csengg@gmail.com>
 <51629DA8.3040806@ti.com>
Message-ID: <20130408075606.5a59d32c@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sekhar,

Em Mon, 8 Apr 2013 16:06:24 +0530
Sekhar Nori <nsekhar@ti.com> escreveu:

> On 4/8/2013 2:56 PM, Prabhakar lad wrote:
> > From: Lad, Prabhakar <prabhakar.csengg@gmail.com>
> > 
> > This patch series enables VPBE display driver on DM355.
> 
> These (this and the DM365 one) patches look good to me. I need to get an
> immutable branch from Mauro where dependencies are queued and then I can
> generate a pull request for these for ARM SoC.

Are you mean a branch at the media development tree for you to sent
pull requests for me? If so, just use the "master" branch at the media
tree:
	http://git.linuxtv.org/media_tree.git

The master branch there is never rebased. I'll likely start to have
topic branches on the next Kernel cycle, also at the same tree.

Regards,
Mauro
