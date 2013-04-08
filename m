From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 8 Apr 2013 17:17:34 +0530
Subject: [PATCH v8 0/2] ARM: davinci: dm355: add support for vpbe display
In-Reply-To: <20130408075606.5a59d32c@redhat.com>
References: <1365413215-3632-1-git-send-email-prabhakar.csengg@gmail.com>
 <51629DA8.3040806@ti.com> <20130408075606.5a59d32c@redhat.com>
Message-ID: <5162AE56.5090203@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maruo,

On 4/8/2013 4:26 PM, Mauro Carvalho Chehab wrote:
> Hi Sekhar,
> 
> Em Mon, 8 Apr 2013 16:06:24 +0530
> Sekhar Nori <nsekhar@ti.com> escreveu:
> 
>> On 4/8/2013 2:56 PM, Prabhakar lad wrote:
>>> From: Lad, Prabhakar <prabhakar.csengg@gmail.com>
>>>
>>> This patch series enables VPBE display driver on DM355.
>>
>> These (this and the DM365 one) patches look good to me. I need to get an
>> immutable branch from Mauro where dependencies are queued and then I can
>> generate a pull request for these for ARM SoC.
> 
> Are you mean a branch at the media development tree for you to sent
> pull requests for me? If so, just use the "master" branch at the media

The pull request will be sent to my upstreams (ie the ARM SoC folks -
Arnd and Olof). Since the platform data patches need driver patches to
be applied first, I need a non-rebasing branch containing the driver
stuff which I can use a dependency and apply platform patches on top.

> tree:
> 	http://git.linuxtv.org/media_tree.git
> 
> The master branch there is never rebased. I'll likely start to have
> topic branches on the next Kernel cycle, also at the same tree.

Ideally I will use the immutable branch which you will also use to send
pull request to Linus so there are not unnecessary merge conflicts. When
will those branches be ready?

Thanks,
Sekhar
