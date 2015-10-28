From: david@protonic.nl (David Jander)
Date: Wed, 28 Oct 2015 13:36:02 +0100
Subject: BUG: fsl FEC ethernet tx checksum offloading doesn't work with
 RMII interface
In-Reply-To: <CAOMZO5D=7Okx-Lju5uzMCXC+_8ETDVmEOfWU7ZD0byZszDSV3A@mail.gmail.com>
References: <20151028104854.025430ce@archvile>
 <20151028111414.GJ8644@n2100.arm.linux.org.uk>
 <20151028121918.4884b42e@archvile>
 <CAOMZO5D=7Okx-Lju5uzMCXC+_8ETDVmEOfWU7ZD0byZszDSV3A@mail.gmail.com>
Message-ID: <20151028133602.0f48dac9@archvile>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 28 Oct 2015 10:31:17 -0200
Fabio Estevam <festevam@gmail.com> wrote:

> On Wed, Oct 28, 2015 at 9:19 AM, David Jander <david@protonic.nl> wrote:
> 
> > Sorry, I somehow assumed it was obvious I'd report against latest
> > mainline... I'm on 4.3-rc7.
> 
> Are you able to find out a previous kernel version that does not
> exhibit this failure?

I can search further down, but 4.1 is also broken.
Are there specific changes or versions you are suspicious of?
Russel mentioned something similar being fixed in the past... any pointers to
this fix, so I can investigate whether this has any relation?

Best regards,

-- 
David Jander
Protonic Holland.
