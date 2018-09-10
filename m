From: jrdr.linux@gmail.com (Souptick Joarder)
Date: Tue, 11 Sep 2018 00:17:45 +0530
Subject: Regression in next with apps hanging with vm_fault_t
In-Reply-To: <20180910182143.GW5662@atomide.com>
References: <20180910182143.GW5662@atomide.com>
Message-ID: <CAFqt6zaRFW+bwVmWbMQ9ni9VJzsa1QMPRLFDCE6X0yQbvbPukw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 10, 2018 at 11:51 PM Tony Lindgren <tony@atomide.com> wrote:
>
> Hi,
>
> I'm seeing a regression with Linux next with commit 7b6ec2ae877a
> ("fs: convert return type int to vm_fault_t") where apps can just
> hang.
>
> The reproducable test case I have is to remove a distro package
> and then add it back where adding the package back just hangs and
> the package file seems corrupted.
>
> This is with ext4 rootfs on MMC, NFSroot does not have this
> issue. Any ideas?

This is a bad commit and there is a plan to remove it from all the tree.
Not sure why it is still showing in linux-next tree.
