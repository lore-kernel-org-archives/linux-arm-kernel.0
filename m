From: broonie@kernel.org (Mark Brown)
Date: Fri, 16 Aug 2013 19:03:59 +0100
Subject: Broken device trees for exynos in linux-next
In-Reply-To: <CAOesGMiyNM6VdNzKQU3XwoiacJV8hc60mcLiH+vHoS6xJM6q-A@mail.gmail.com>
References: <CAOesGMgv9gTQ_NtaKZY_ZfLD1NBU19E-vaLaWwmvGJJB1MQrwg@mail.gmail.com>
 <13b101ce9a14$2cebd700$86c38500$@org>
 <CAOesGMiyNM6VdNzKQU3XwoiacJV8hc60mcLiH+vHoS6xJM6q-A@mail.gmail.com>
Message-ID: <20130816180359.GO30073@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 16, 2013 at 09:04:41AM -0700, Olof Johansson wrote:

> Really, what we want is to just turn on the LPAE functionality and
> keep everything else common. Forking into two defconfigs seems like

There's issues with that at the minute due to the DMA mask fun breaking
stuff, though Russell's work has resolved that it should work fine.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130816/4b7151cc/attachment.sig>
