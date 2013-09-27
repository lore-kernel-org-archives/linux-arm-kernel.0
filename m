From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 27 Sep 2013 18:32:42 +0200
Subject: [PATCH] misc: (at24) move header to linux/platform_data/
In-Reply-To: <1414767040.1054326.1380226152008.JavaMail.root@mail>
References: <169123028.921974.1377290733515.JavaMail.root@mail>
 <1414767040.1054326.1380226152008.JavaMail.root@mail>
Message-ID: <20130927163242.GB3094@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 26, 2013 at 04:09:12PM -0400, Vivien Didelot wrote:
> Hi Wolfram,
> 
> > Wolfram wrote:
> > 
> > > > IMHO it makes sense. Why wouldn't we want all platform_data in
> > > > include/linux/platform_data/?
> > > 
> > > For the same reason we don't want all driver source files in one
> > > directory? It's a mess.
> > 
> > Well, that's different. Not all drivers expose platform data, but
> > many subsystems have drivers with platform data. A common include
> > directory for the *_platform_data structure definitions makes sense.
> 
> Also IMO having such header file in include/linux/i2c/ for a driver
> declared in drivers/misc/eeprom/ is not very consistent.
> So this is the purpose of this include directory. What do you think?

Well, yes, I will apply it if you could rebase it onto v3.12-rc2. I am
unsure about the platform_data dir in general, though. For example, I'd
prefer to have the i2c-* files in the i2c-dir, but this is another
question.

Thanks,

   Wolfram

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130927/13b6ef67/attachment.sig>
