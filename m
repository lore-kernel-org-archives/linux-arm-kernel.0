From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 2 May 2018 05:39:23 -0700
Subject: [PATCH v2 08/10] PCI: Deprecate of_pci_get_host_bridge_resources()
In-Reply-To: <aca0d89cd8c1551a83b87ffab29fcd6e1d59a61c.1525067324.git.jan.kiszka@siemens.com>
References: <cover.1525067324.git.jan.kiszka@siemens.com>
 <aca0d89cd8c1551a83b87ffab29fcd6e1d59a61c.1525067324.git.jan.kiszka@siemens.com>
Message-ID: <20180502123923.GA10783@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 30, 2018 at 07:48:42AM +0200, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> There are no in-tree users remaining, all are converted to the managed
> variant. And it is unlikely that any out-of-tree user got the resource
> management right as well. So deprecate the interface and push users to
> the managed version instead.
> 
> To avoid raising a warning when exporting a deprecated symbol, wrap the
> API with an inline and export an internal name.

Don't deprecated it, just remove it.
