From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 25 Feb 2015 15:08:53 +0000
Subject: [PATCH 2/6] ahci: st: Update the DT example for how to obtain
 the PHY.
In-Reply-To: <CAL_JsqLbQWK-iZ+bH7SJzUjUZzYkdPVoDFSjaFd9TS29YOVQkA@mail.gmail.com>
References: <1424871377-1795-1-git-send-email-peter.griffin@linaro.org>
 <1424871377-1795-3-git-send-email-peter.griffin@linaro.org>
 <CAL_JsqLbQWK-iZ+bH7SJzUjUZzYkdPVoDFSjaFd9TS29YOVQkA@mail.gmail.com>
Message-ID: <20150225150853.GC5132@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 25 Feb 2015, Rob Herring wrote:

> On Wed, Feb 25, 2015 at 7:36 AM, Peter Griffin <peter.griffin@linaro.org> wrote:
> > The example is wrong in that the phys property should take a
> > phandle to the phy port.
> >
> > Also with the changing over to generic PHY type constants we also
> > update this as well.
> >
> > Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> 
> We seem to have a variety of ways to describe phy's with SATA
> controllers. Some consistency would have been nice.

This way is the correct way.  I worked closely with Kishon to get it
right.  He even used this code as an example at ELC, Dusseldorf.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
