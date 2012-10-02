From: konrad@kernel.org (Konrad Rzeszutek Wilk)
Date: Tue, 2 Oct 2012 14:51:19 -0400
Subject: [PATCH] xen: resolve merge conflict with
 617276307cd4cdb9a95c77efaa3063695af63aa7
In-Reply-To: <alpine.DEB.2.02.1210021724300.29232@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1210021724300.29232@kaball.uk.xensource.com>
Message-ID: <CACJDEmrV4uqLQ5wPGTQ7vHRAo3hHXDdWrTB5h65hfF+B9rJCgQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 2, 2012 at 1:29 PM, Stefano Stabellini
<stefano.stabellini@eu.citrix.com> wrote:
> The Xen tree tries to add a line to
> arch/arm/mach-vexpress/Makefile.boot that has been removed by the
> following commit in Linus' master:
>
> commit 617276307cd4cdb9a95c77efaa3063695af63aa7
> Author: Rob Herring <rob.herring@calxeda.com>
> Date:   Thu Sep 6 13:43:04 2012 -0500
>
>     ARM: vexpress: convert to multi-platform
>
> In fact the dts Makefile is now arch/arm/boot/dts/Makefile, as per
> commit 9cd11c0c47b8690b47e7573311ce5c483cb344ed.
>
>
> This is the merge resolution patch.
>
> Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>

Great. Thanks for posting it!
