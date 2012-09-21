From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 21 Sep 2012 14:49:56 +0000
Subject: [PATCH 01/11] ARM: defconfig: Remove CONFIG_MISC_DEVICES
In-Reply-To: <CAOMZO5C2rTBM6si0MUC7XWznwqwmUq5-LmFyekLab8UBVwaCFw@mail.gmail.com>
References: <1345307035-3545-1-git-send-email-festevam@gmail.com>
 <CAOMZO5C2ihKUeQk17JOHc9VXAB3KTeQLS3OcLOiiUC8jucsexg@mail.gmail.com>
 <CAOMZO5C2rTBM6si0MUC7XWznwqwmUq5-LmFyekLab8UBVwaCFw@mail.gmail.com>
Message-ID: <201209211449.56906.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 21 September 2012, Fabio Estevam wrote:
> Hi Arnd,
> 
> On Thu, Sep 6, 2012 at 7:25 PM, Fabio Estevam <festevam@gmail.com> wrote:
> 
> > I am not sure who would pick up this series.
> >
> > Is it possible for you to apply these patches?
> 
> Is this something you can help with?
> 

Hi Fabio,

Sorry for not replying earlier. We could merge these through the
arm-soc tree, but I'm not actually sure if they are necessary.

For all I know, listing a nonexisting configuration option in
a defconfig file has no effect, and the files get recreated
whenever the maintainers choose to.

Is there anything I am missing?

	Arnd
