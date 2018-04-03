From: gregkh@linuxfoundation.org (gregkh)
Date: Tue, 3 Apr 2018 18:31:59 +0200
Subject: stable-rc build: 4 warnings 0 failures (stable-rc/v4.15.15)
In-Reply-To: <CAK8P3a1-VqB8mbixuHdsZbfCbGBpVppO4KX4VuZ5AJCHbYooAA@mail.gmail.com>
References: <5abfca32.5d57620a.a2eca.898b@mx.google.com>
 <CAK8P3a1-VqB8mbixuHdsZbfCbGBpVppO4KX4VuZ5AJCHbYooAA@mail.gmail.com>
Message-ID: <20180403163159.GA16449@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 03, 2018 at 04:47:31PM +0200, Arnd Bergmann wrote:
> On Sat, Mar 31, 2018 at 7:49 PM, Olof's autobuilder <build@lixom.net> wrote:
> 
> > Warnings:
> >
> >         arm64.allmodconfig:
> > WARNING: modpost: missing MODULE_LICENSE() in drivers/phy/qualcomm/phy-qcom-ufs.o
> 
> This needs a backport of
> 
> 59fba0869aca ("phy: qcom-ufs: add MODULE_LICENSE tag")

Now added, thanks!

greg k-h
