From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Tue, 6 Oct 2015 14:55:57 +0100
Subject: [PATCH v4 00/20] xen/arm64: Add support for 64KB page in Linux
In-Reply-To: <56139428.4050402@citrix.com>
References: <1441640038-23615-1-git-send-email-julien.grall@citrix.com>
 <55F68BC9.6020509@citrix.com> <55F6A437.3040403@citrix.com>
 <55F6A9DB.8040503@citrix.com> <55F6ADAE.1010609@citrix.com>
 <55F6B8CC.5090406@citrix.com> <55F6C1D2.7010206@citrix.com>
 <55F6D9DC.8060607@citrix.com>
 <alpine.DEB.2.02.1509141542430.2672@kaball.uk.xensource.com>
 <55F6E658.4070908@citrix.com> <1442919576.10338.146.camel@citrix.com>
 <56139428.4050402@citrix.com>
Message-ID: <alpine.DEB.2.02.1510061450230.1179@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 6 Oct 2015, Roger Pau Monn? wrote:
> Do KVM guests also need such extensive set of modifications in order to
> run using 64KB pages? I know it's not fair to compare KVM and Xen in
> this regard, because the interfaces are very different, but that's what
> developers are going to look at.

QEMU doesn't need extensive modifications to run 64K guests on a 4K
host, but on the other hand KVM needs its own set of non-trivial
modifications to do it.
