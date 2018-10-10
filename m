From: robh+dt@kernel.org (Rob Herring)
Date: Wed, 10 Oct 2018 14:05:43 -0500
Subject: [PATCH v3 2/2] treewide: use bus_find_device_by_fwnode
In-Reply-To: <CALabi0FgQWGL8KMpCKt9N6Kkoig77LxOsea3Oe47tk5nOH10-Q@mail.gmail.com>
References: <1539080245-25818-1-git-send-email-svellattu@mvista.com>
 <1539080245-25818-2-git-send-email-svellattu@mvista.com>
 <20181009174428.GB2182@xps15>
 <CALabi0FgQWGL8KMpCKt9N6Kkoig77LxOsea3Oe47tk5nOH10-Q@mail.gmail.com>
Message-ID: <CAL_JsqJsF0Zr=chBQ_Euq+27TJftpSR5dpi-tYyiwEFdsEh6vQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 9, 2018 at 9:59 PM Silesh C V <svellattu@mvista.com> wrote:
>
> Hello Mathieu,
>
> On Tue, Oct 9, 2018 at 11:14 PM Mathieu Poirier
> <mathieu.poirier@linaro.org> wrote:
> >
> >
> > This doesn't apply on linux-next.  This late in the cycle you may want to rebase
> > your work on that tree.
>
> OK. Will send v4 after rebasing onto linux-next.

That doesn't help anything unless you are targeting 4.21. If you are
it would be easiest to apply patch 1 in 4.20 and split this patch by
subsystem for 4.21. That avoids any cross subsystem dependencies.

Rob
