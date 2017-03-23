From: sre@kernel.org (Sebastian Reichel)
Date: Thu, 23 Mar 2017 10:35:27 +0100
Subject: [RESEND PATCH v4 2/9] iio: adc: add support for X-Powers AXP20X
 and AXP22X PMICs ADCs
In-Reply-To: <CAGb2v66JC65=9WiMy-Nu+9tTFRLsJL2Eyb0wfJV_K=65ABc6Zg@mail.gmail.com>
References: <20170320081653.8884-1-quentin.schulz@free-electrons.com>
 <20170320081653.8884-3-quentin.schulz@free-electrons.com>
 <CAGb2v66JC65=9WiMy-Nu+9tTFRLsJL2Eyb0wfJV_K=65ABc6Zg@mail.gmail.com>
Message-ID: <20170323093527.ojcdpvruzqnhvysq@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Mar 22, 2017 at 12:34:45PM +0800, Chen-Yu Tsai wrote:
> P.S. I'm thinking about having MFD_AXP20X imply its various sub-drivers.
> Not sure if that was the intended usage of the new imply syntax though.

I think adding "default MFD_AXP20X" to the sub-drivers is cleaner,
as you will not end up with a long list.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170323/ca312157/attachment.sig>
