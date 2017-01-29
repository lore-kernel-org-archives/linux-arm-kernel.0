From: sre@kernel.org (Sebastian Reichel)
Date: Sun, 29 Jan 2017 17:47:19 +0100
Subject: [PATCH v2 16/25] dt-bindings: power: supply: add AXP20X/AXP22X
 battery DT binding
In-Reply-To: <20170127085458.18270-17-quentin.schulz@free-electrons.com>
References: <20170127085458.18270-1-quentin.schulz@free-electrons.com>
 <20170127085458.18270-17-quentin.schulz@free-electrons.com>
Message-ID: <20170129164719.eulijkfarzrm2o6j@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jan 27, 2017 at 09:54:49AM +0100, Quentin Schulz wrote:
>  - added x-powers,constant-charge-current property to set the
>  maximal default constant current charge of the battery,

Since this is information about the battery and not the fuel-gauge,
it should use the WIP "framework" for information about batteries.

Have a look at the following patchset:

http://marc.info/?l=linux-pm&m=148411561025684&w=2

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170129/ff6a4113/attachment.sig>
