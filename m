From: kgene@kernel.org (kgene at kernel.org)
Date: Tue, 09 Sep 2014 12:47:35 +0900
Subject: [PATCH v2 0/5] Add max77802 support for Peach boards
In-Reply-To: <CABxcv==ycrPw1MTv7X0baX2WfqgDS+4EEfGAWc+ZhpiR6=Uy+Q@mail.gmail.com>
References: <1408533593-32346-1-git-send-email-javier.martinez@collabora.co.uk>
 <CABxcv==ycrPw1MTv7X0baX2WfqgDS+4EEfGAWc+ZhpiR6=Uy+Q@mail.gmail.com>
Message-ID: <04ab01cfcbe0$caeac4d0$60c04e70$@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Javier Martinez Canillas wrote:
> 
> Hello Kukjin,
> 
Hi,

> On Wed, Aug 20, 2014 at 1:19 PM, Javier Martinez Canillas
> <javier.martinez@collabora.co.uk> wrote:
> >
> > This is a second version of the series that adds max77802 support for
> > the Peach Pit and Pi boards. The series also have all the pending
> > patches that were posted but depended on this support. I've picked
> > all the patches I found and rebased them to be sure that they apply
> > cleanly on top of linux-next. Also I've taken some DT snippets from
> > the downstream Chrome OS 3.8 kernel DTS for devices that use one of
> > these regulators as their input supply.
> >
> 
> Any comments on this series?
> 
Looks good to me but I just wanted to get ack from chrome guy, Doug? But since
Naveen tested, it should be fine I think. I'll take the series.

Thanks,
Kukjin
