From: JBeulich@suse.com (Jan Beulich)
Date: Mon, 14 Sep 2015 05:34:35 -0600
Subject: [Xen-devel] [PATCH] efi/libstub/fdt: Standardize the names
 of EFI stub parameters
In-Reply-To: <CAKv+Gu_k4-BqW7CQwB82-GfeXXNKk0bCjr=ZNFy1iDBNzKNWSg@mail.gmail.com>
References: <20150910112418.GC29293@leverpostej>
 <alpine.DEB.2.02.1509101223580.2672@kaball.uk.xensource.com>
 <20150910121514.GE29293@leverpostej>
 <alpine.DEB.2.02.1509101429480.2672@kaball.uk.xensource.com>
 <20150910144938.GI29293@leverpostej>
 <alpine.DEB.2.02.1509101655020.2672@kaball.uk.xensource.com>
 <20150910162302.GN29293@leverpostej>
 <20150911124643.GB4530@olila.local.net-space.pl>
 <alpine.DEB.2.02.1509111410180.2672@kaball.uk.xensource.com>
 <CAKv+Gu9rN7_mxk0huX+34HSCC_aTWVTkUZKQMB1+9U56fRnwsA@mail.gmail.com>
 <20150911154534.GD4530@olila.local.net-space.pl>
 <55F6886D.1090900@huawei.com>
 <CAKv+Gu-xAAd=xTOh+qZvPDthgbRPLy=YwT4xfi4dS53EgJRh1Q@mail.gmail.com>
 <55F693F5.8030203@huawei.com>
 <CAKv+Gu-2kyd3Gf3ceSa1jdgCjqJ8zBCesa4xehLiZ+VzergS3Q@mail.gmail.com>
 <55F6C01502000078000A2823@prv-mh.provo.novell.com>
 <CAKv+Gu_k4-BqW7CQwB82-GfeXXNKk0bCjr=ZNFy1iDBNzKNWSg@mail.gmail.com>
Message-ID: <55F6CCEB02000078000A28CC@prv-mh.provo.novell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>> On 14.09.15 at 13:16, <ard.biesheuvel@linaro.org> wrote:
> (I still think not using SetVirtualAddressMap() at all
> would be the best approach for arm64, but unfortunately, most of my
> colleagues disagree with me)

Any reasons they have? I'm curious because we run x86 Xen without
using this function ...

Jan
