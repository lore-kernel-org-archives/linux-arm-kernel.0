From: broonie@kernel.org (Mark Brown)
Date: Fri, 24 Nov 2017 11:14:27 +0000
Subject: mainline boot: 8 passed 1 failed (mainline/v4.14)
In-Reply-To: <CAOesGMgdqNrZbF5dOEdHKmuNVZiiFoV0_ipsPBi5HkGZUgYm_g@mail.gmail.com>
References: <5a16144d.0be9620a.4490d.4375@mx.google.com>
 <CAK8P3a1OWob9We9zfvhBRN=fQYsw+nkZpqMJ9z6Q_A-N9_V3rQ@mail.gmail.com>
 <CAOesGMgdqNrZbF5dOEdHKmuNVZiiFoV0_ipsPBi5HkGZUgYm_g@mail.gmail.com>
Message-ID: <20171124111427.zzfi6dw27fm6y2rb@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 23, 2017 at 11:40:21AM -0800, Olof Johansson wrote:

> Looks like kernelci doesn't cover CONFIG_SMP=n boots, so I guess this
> might be a new issue.

We turned it off because it was constantly broken and nobody really
cared - personally I'm not sure it's worth doing on systems that aren't
actually uniprocessor.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171124/65714912/attachment.sig>
